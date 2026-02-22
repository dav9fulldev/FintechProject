from fastapi import APIRouter, Depends, HTTPException, status, Header
from sqlalchemy.orm import Session
from datetime import datetime
from typing import List, Optional
from pydantic import BaseModel
from ..models.database import get_db
from ..models.planned_purchase import PlannedPurchase, PurchaseStatus, CategoryEnum
from ..models.user import User
from .auth import get_current_user

router = APIRouter(prefix="/planned-purchases", tags=["planned_purchases"])


# ==================== PYDANTIC MODELS ====================

class PlannedPurchaseCreate(BaseModel):
    name: str
    description: Optional[str] = None
    amount: float
    category: str
    planned_date: Optional[datetime] = None


class PlannedPurchaseUpdate(BaseModel):
    name: Optional[str] = None
    description: Optional[str] = None
    amount: Optional[float] = None
    category: Optional[str] = None
    planned_date: Optional[datetime] = None
    status: Optional[str] = None


class PlannedPurchaseResponse(BaseModel):
    id: int
    user_id: int
    name: str
    description: Optional[str]
    amount: float
    category: str
    planned_date: Optional[datetime]
    created_at: datetime
    purchased_at: Optional[datetime]
    status: str
    transaction_id: Optional[int]

    class Config:
        from_attributes = True


# ==================== ENDPOINTS ====================

@router.post("/", response_model=PlannedPurchaseResponse, status_code=status.HTTP_201_CREATED)
def create_planned_purchase(
    purchase: PlannedPurchaseCreate,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):
    """
    Ajoute un article à la liste des achats futurs.
    L'IA s'en servira pour valider les futures transactions de l'utilisateur.
    """
    try:
        category_enum = CategoryEnum(purchase.category)
    except ValueError:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail=f"Catégorie invalide: {purchase.category}"
        )
    
    new_purchase = PlannedPurchase(
        user_id=current_user.id,
        name=purchase.name,
        description=purchase.description,
        amount=purchase.amount,
        category=category_enum,
        planned_date=purchase.planned_date,
        status=PurchaseStatus.PENDING
    )
    
    db.add(new_purchase)
    db.commit()
    db.refresh(new_purchase)
    
    return new_purchase


@router.get("/", response_model=List[PlannedPurchaseResponse])
def get_planned_purchases(
    status_filter: Optional[str] = None,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):
    """Récupérer tous les achats planifiés de l'utilisateur"""
    query = db.query(PlannedPurchase).filter(PlannedPurchase.user_id == current_user.id)
    
    if status_filter:
        try:
            status_enum = PurchaseStatus(status_filter)
            query = query.filter(PlannedPurchase.status == status_enum)
        except ValueError:
            raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST,
                detail=f"Statut invalide: {status_filter}"
            )
    
    purchases = query.order_by(PlannedPurchase.created_at.desc()).all()
    return purchases


@router.get("/{purchase_id}", response_model=PlannedPurchaseResponse)
def get_planned_purchase(
    purchase_id: int,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):
    """Récupérer un achat planifié spécifique"""
    purchase = db.query(PlannedPurchase).filter(
        PlannedPurchase.id == purchase_id,
        PlannedPurchase.user_id == current_user.id
    ).first()
    
    if not purchase:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Achat planifié introuvable"
        )
    
    return purchase


@router.put("/{purchase_id}", response_model=PlannedPurchaseResponse)
def update_planned_purchase(
    purchase_id: int,
    purchase_update: PlannedPurchaseUpdate,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):
    """Mettre à jour un achat planifié"""
    purchase = db.query(PlannedPurchase).filter(
        PlannedPurchase.id == purchase_id,
        PlannedPurchase.user_id == current_user.id
    ).first()
    
    if not purchase:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Achat planifié introuvable"
        )
    
    # Mettre à jour les champs fournis
    if purchase_update.name is not None:
        purchase.name = purchase_update.name
    if purchase_update.description is not None:
        purchase.description = purchase_update.description
    if purchase_update.amount is not None:
        purchase.amount = purchase_update.amount
    if purchase_update.category is not None:
        try:
            purchase.category = CategoryEnum(purchase_update.category)
        except ValueError:
            raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST,
                detail=f"Catégorie invalide: {purchase_update.category}"
            )
    if purchase_update.planned_date is not None:
        purchase.planned_date = purchase_update.planned_date
    if purchase_update.status is not None:
        try:
            purchase.status = PurchaseStatus(purchase_update.status)
        except ValueError:
            raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST,
                detail=f"Statut invalide: {purchase_update.status}"
            )
    
    db.commit()
    db.refresh(purchase)
    
    return purchase


@router.post("/{purchase_id}/mark-purchased", response_model=PlannedPurchaseResponse)
def mark_as_purchased(
    purchase_id: int,
    transaction_id: Optional[int] = None,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):
    """
    Réconciliation : Marque un achat planifié comme 'effectué'.
    Lien optionnel avec une transaction réelle pour le suivi comptable.
    """
    purchase = db.query(PlannedPurchase).filter(
        PlannedPurchase.id == purchase_id,
        PlannedPurchase.user_id == current_user.id
    ).first()
    
    if not purchase:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Achat planifié introuvable"
        )
    
    purchase.status = PurchaseStatus.PURCHASED
    purchase.purchased_at = datetime.utcnow()
    if transaction_id:
        purchase.transaction_id = transaction_id
    
    db.commit()
    db.refresh(purchase)
    
    return purchase


@router.delete("/{purchase_id}", status_code=status.HTTP_204_NO_CONTENT)
def delete_planned_purchase(
    purchase_id: int,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):
    """Supprimer un achat planifié"""
    purchase = db.query(PlannedPurchase).filter(
        PlannedPurchase.id == purchase_id,
        PlannedPurchase.user_id == current_user.id
    ).first()
    
    if not purchase:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Achat planifié introuvable"
        )
    
    db.delete(purchase)
    db.commit()
    
    return None


@router.get("/stats/summary")
def get_summary(
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):
    """Obtenir un résumé des achats planifiés"""
    purchases = db.query(PlannedPurchase).filter(
        PlannedPurchase.user_id == current_user.id
    ).all()
    
    total_planned = sum(p.amount for p in purchases if p.status == PurchaseStatus.PENDING)
    total_purchased = sum(p.amount for p in purchases if p.status == PurchaseStatus.PURCHASED)
    
    pending_count = len([p for p in purchases if p.status == PurchaseStatus.PENDING])
    purchased_count = len([p for p in purchases if p.status == PurchaseStatus.PURCHASED])
    
    return {
        "total_planned_amount": total_planned,
        "total_purchased_amount": total_purchased,
        "pending_count": pending_count,
        "purchased_count": purchased_count,
        "total_count": len(purchases)
    }
