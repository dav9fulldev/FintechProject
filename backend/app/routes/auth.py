from fastapi import APIRouter, Depends, HTTPException, status, Header
from fastapi.security import OAuth2PasswordBearer, OAuth2PasswordRequestForm
from sqlalchemy.orm import Session
from datetime import datetime, timedelta
from dateutil.relativedelta import relativedelta
from jose import JWTError, jwt
from passlib.context import CryptContext
import bcrypt
from typing import Optional, List
from ..models.database import get_db
from ..models.user import User
from ..models.budget import Budget
from ..models.goal import Goal
from pydantic import BaseModel, EmailStr
import os

router = APIRouter(prefix="/auth", tags=["authentication"])

pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")
oauth2_scheme = OAuth2PasswordBearer(tokenUrl="auth/login")

# Configuration de la sécurité JWT
# SECRET_KEY doit rester privé pour empêcher la forge de faux tokens
SECRET_KEY = os.getenv("SECRET_KEY", "your-secret-key")
ALGORITHM = os.getenv("ALGORITHM", "HS256")

class UserCreate(BaseModel):
    email: EmailStr
    username: Optional[str] = None
    phone: Optional[str] = None
    password: str
    first_name: Optional[str] = None
    last_name: Optional[str] = None
    profession: Optional[str] = None
    income_range: Optional[str] = None
    goals: Optional[List[str]] = None
    spending_categories: Optional[List[str]] = None

class LoginRequest(BaseModel):
    email: EmailStr
    password: str

class UserResponse(BaseModel):
    id: int
    email: str
    username: str
    first_name: Optional[str] = None
    last_name: Optional[str] = None
    profession: Optional[str] = None
    income_range: Optional[str] = None
    phone: Optional[str] = None
    is_active: bool = True
    created_at: datetime

    class Config:
        from_attributes = True

class Token(BaseModel):
    access_token: str
    token_type: str
    user: Optional[UserResponse] = None

class GoogleAuthRequest(BaseModel):
    id_token: str

def verify_password(plain_password, hashed_password):
    return pwd_context.verify(plain_password, hashed_password)
    """
    Vérifie si le mot de passe en clair correspond au hash stocké.
    Utilise bcrypt directement pour plus de robustesse sur Windows.
    """
    # Sécurité : bcrypt limite les mots de passe à 72 octets
    password_bytes = plain_password.encode('utf-8')[:72]
    hashed_bytes = hashed_password.encode('utf-8')
    return bcrypt.checkpw(password_bytes, hashed_bytes)

def get_password_hash(password):
    return pwd_context.hash(password)
    """Hash password using bcrypt directly"""
    # Truncate password to 72 bytes (bcrypt limit)
    password_bytes = password.encode('utf-8')[:72]
    salt = bcrypt.gensalt()
    hashed = bcrypt.hashpw(password_bytes, salt)
    return hashed.decode('utf-8')

def create_access_token(data: dict):
    """
    Génère un jeton JWT signé pour authentifier les requêtes futures.
    Le jeton contient l'identifiant utilisateur (sub) et une date d'expiration.
    """
    to_encode = data.copy()
    expire = datetime.utcnow() + timedelta(minutes=int(os.getenv("ACCESS_TOKEN_EXPIRE_MINUTES", 30)))
    to_encode.update({"exp": expire})
    encoded_jwt = jwt.encode(to_encode, SECRET_KEY, algorithm=ALGORITHM)
    return encoded_jwt

@router.post("/register", response_model=Token)
def register(user: UserCreate, db: Session = Depends(get_db)):
    """
    Inscrit un nouvel utilisateur et initialise son profil financier.
    Crée automatiquement des objectifs d'épargne basés sur ses choix.
    """
    db_user = db.query(User).filter(User.email == user.email).first()
    if db_user:
        raise HTTPException(status_code=400, detail="Email déjà enregistré")
    
    # Générer un username si non fourni
    username = user.username
    if not username:
        # Utiliser le prénom+nom ou l'email comme base
        if user.first_name and user.last_name:
            username = f"{user.first_name.lower()}{user.last_name.lower()}".replace(" ", "")
        else:
            username = user.email.split("@")[0]
    
    hashed_password = get_password_hash(user.password)
    new_user = User(
        email=user.email,
        username=username,
        phone=user.phone,
        first_name=user.first_name,
        last_name=user.last_name,
        profession=user.profession,
        income_range=user.income_range,
        hashed_password=hashed_password
    )
    db.add(new_user)
    db.commit()
    db.refresh(new_user)
    
    # Note: Les spending_categories sont maintenant utilisées uniquement pour personnaliser l'IA
    # L'utilisateur créera sa propre liste d'achats après l'inscription
    
    # Créer des objectifs basés sur les goals sélectionnés
    if user.goals:
        # Mapping des valeurs Flutter vers les noms affichés
        goal_mapping = {
            "terrain": "Acheter un terrain",
            "voiture": "Acheter une voiture",
            "mariage": "Préparer un mariage",
            "etudes": "Financer des études",
            "voyage": "Voyager",
            "entreprise": "Créer une entreprise",
            "epargne": "Constituer une épargne",
            "brvm": "Investir en bourse (BRVM)",
            "gestion": "Mieux gérer mon budget",
            "suivi": "Suivre mes dépenses"
        }
        
        goal_amounts = {
            "Acheter un terrain": 3000000,
            "Acheter une voiture": 2000000,
            "Préparer un mariage": 1500000,
            "Financer des études": 500000,
            "Voyager": 300000,
            "Créer une entreprise": 3000000,
            "Constituer une épargne": 500000,
            "Investir en bourse (BRVM)": 1000000,
            "Mieux gérer mon budget": 100000,
            "Suivre mes dépenses": 100000
        }
        
        current_date = datetime.utcnow()
        for goal_key in user.goals:
            goal_name = goal_mapping.get(goal_key, goal_key.capitalize())
            target_amount = goal_amounts.get(goal_name, 500000)
            goal = Goal(
                user_id=new_user.id,
                name=goal_name,
                target_amount=target_amount,
                current_amount=0.0,
                target_date=current_date + relativedelta(months=12),
                description=f"Objectif: {goal_name}",
                icon="flag",
                color="#00A86B"
            )
            db.add(goal)
    
    db.commit()
    
    access_token = create_access_token(data={"sub": new_user.email})
    return {
        "access_token": access_token,
        "token_type": "bearer",
        "user": {
            "id": new_user.id,
            "email": new_user.email,
            "username": new_user.username,
            "first_name": new_user.first_name,
            "last_name": new_user.last_name,
            "profession": new_user.profession,
            "income_range": new_user.income_range,
            "phone": new_user.phone,
            "is_active": new_user.is_active,
            "created_at": new_user.created_at.isoformat() if new_user.created_at else datetime.utcnow().isoformat(),
        }
    }

@router.post("/login", response_model=Token)
def login(login_data: LoginRequest, db: Session = Depends(get_db)):
    user = db.query(User).filter(User.email == login_data.email).first()
    if not user or not verify_password(login_data.password, user.hashed_password):
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Email ou mot de passe incorrect"
        )

    access_token = create_access_token(data={"sub": user.email})
    return {
        "access_token": access_token,
        "token_type": "bearer",
        "user": {
            "id": user.id,
            "email": user.email,
            "username": user.username,
            "first_name": user.first_name,
            "last_name": user.last_name,
            "profession": user.profession,
            "income_range": user.income_range,
            "phone": user.phone,
            "is_active": user.is_active,
            "created_at": user.created_at.isoformat() if user.created_at else datetime.utcnow().isoformat(),
        }
    }

@router.post("/google", response_model=Token)
def google_auth(google_data: GoogleAuthRequest, db: Session = Depends(get_db)):
    """
    Authenticate user with Google ID token
    
    This endpoint:
    1. Verifies the Google ID token
    2. Checks if user exists by google_id or email
    3. Creates new user if needed
    4. Returns JWT access token
    """
    try:
        # Import the google auth verifier
        from ..utils.google_auth import GoogleAuthVerifier
        
        # Get the Google Client ID from environment
        google_client_id = os.getenv("GOOGLE_CLIENT_ID")
        if not google_client_id:
            raise HTTPException(
                status_code=500,
                detail="Google Client ID non configuré"
            )
        
        # Verify the ID token
        verifier = GoogleAuthVerifier(client_id=google_client_id)
        user_info = verifier.verify_token(google_data.id_token)

        # Check if user exists by google_id
        user = db.query(User).filter(User.google_id == user_info["google_id"]).first()

        # If not found, check by email
        if not user:
            user = db.query(User).filter(User.email == user_info["email"]).first()

            if user:
                # Update existing user with google info
                user.google_id = user_info["google_id"]
                user.auth_provider = "google"
                user.profile_picture = user_info.get("picture")
            else:
                # Create new user
                username = user_info.get('name') or user_info['email'].split('@')[0]

                # Ensure username is unique
                base_username = username
                counter = 1
                while db.query(User).filter(User.username == username).first():
                    username = f"{base_username}{counter}"
                    counter += 1

                user = User(
                    email=user_info["email"],
                    username=username,
                    first_name=user_info.get("given_name"),
                    last_name=user_info.get("family_name"),
                    google_id=user_info["google_id"],
                    auth_provider="google",
                    profile_picture=user_info.get("picture")
                )
                db.add(user)
                db.commit()
                db.refresh(user)

        # Generate JWT token
        access_token = create_access_token(data={"sub": user.email})

        return {"access_token": access_token, "token_type": "bearer"}

    except ValueError as e:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail=str(e)
        )
    except Exception as e:
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail=f"Authentication failed: {str(e)}"
        )
class UserResponse(BaseModel):
    id: int
    email: str
    username: str
    phone: Optional[str] = None
    first_name: Optional[str] = None
    is_active: bool

    class Config:
        from_attributes = True


def get_current_user(authorization: Optional[str] = Header(None), db: Session = Depends(get_db)):
    """
    Sécurité : Dépendance pour protéger les routes.
    Extrait le token JWT du header 'Authorization', le valide, et récupère l'utilisateur en DB.
    """
    credentials_exception = HTTPException(
        status_code=status.HTTP_401_UNAUTHORIZED,
        detail="Token invalide ou expiré",
        headers={"WWW-Authenticate": "Bearer"},
    )
    
    if not authorization or not authorization.startswith("Bearer "):
        raise credentials_exception
    
    token = authorization.split(" ")[1]
    
    try:
        payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
        email: str = payload.get("sub")
        if email is None:
            raise credentials_exception
    except JWTError:
        raise credentials_exception

    user = db.query(User).filter(User.email == email).first()
    if user is None:
        raise credentials_exception
    return user


@router.get("/me", response_model=UserResponse)
def get_me(current_user: User = Depends(get_current_user)):
    """Récupérer les informations de l'utilisateur connecté"""
    return current_user


@router.put("/me", response_model=UserResponse)
def update_me(
    username: str = None,
    phone: str = None,
    first_name: str = None,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):
    """Mettre à jour le profil de l'utilisateur"""
    if username:
        current_user.username = username
    if phone:
        current_user.phone = phone
    if first_name:
        current_user.first_name = first_name

    db.commit()
    db.refresh(current_user)
    return current_user


class ChangePasswordRequest(BaseModel):
    current_password: str
    new_password: str


@router.post("/change-password")
def change_password(
    request: ChangePasswordRequest,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):
    """Changer le mot de passe de l'utilisateur"""
    # Vérifier le mot de passe actuel
    if not verify_password(request.current_password, current_user.hashed_password):
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Mot de passe actuel incorrect"
        )
    
    # Vérifier que le nouveau mot de passe est différent
    if request.current_password == request.new_password:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Le nouveau mot de passe doit être différent de l'ancien"
        )
    
    # Vérifier la longueur du nouveau mot de passe
    if len(request.new_password) < 8:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Le mot de passe doit contenir au moins 8 caractères"
        )
    
    # Mettre à jour le mot de passe
    current_user.hashed_password = get_password_hash(request.new_password)
    db.commit()
    
    return {"message": "Mot de passe modifié avec succès"}
