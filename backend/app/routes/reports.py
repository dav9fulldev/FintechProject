from fastapi import APIRouter, Depends, HTTPException, status
from fastapi.responses import StreamingResponse, JSONResponse
from typing import Optional
from datetime import datetime, date
from io import BytesIO
from ..services.report_service import generate_monthly_report_bytes, send_report_via_email
from ..routes.auth import get_current_user
from sqlalchemy.orm import Session
from ..models.database import get_db

router = APIRouter(prefix="/reports", tags=["reports"])


@router.get("/monthly/download")
def download_monthly_report(year: Optional[int] = None, month: Optional[int] = None, db: Session = Depends(get_db), current_user = Depends(get_current_user)):
    """Génère et renvoie le PDF du rapport pour l'utilisateur. Si year/month non fournis, prend le mois précédent."""
    today = datetime.utcnow().date()
    if year is None or month is None:
        # mois précédent
        first_of_month = date(today.year, today.month, 1)
        prev_month_last_day = first_of_month - (datetime.min - datetime.min)
        # simpler: compute previous month
        if today.month == 1:
            year = today.year - 1
            month = 12
        else:
            year = today.year
            month = today.month - 1

    try:
        pdf_bytes = generate_monthly_report_bytes(db, current_user, year, month)
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

    return StreamingResponse(BytesIO(pdf_bytes), media_type="application/pdf", headers={
        "Content-Disposition": f"attachment; filename=rapport_{year}_{month}.pdf"
    })


from pydantic import BaseModel, EmailStr


class SendReportRequest(BaseModel):
    email: Optional[EmailStr] = None
    year: Optional[int] = None
    month: Optional[int] = None


@router.post("/monthly/send")
def send_monthly_report(req: SendReportRequest, db: Session = Depends(get_db), current_user = Depends(get_current_user)):
    """Génère le rapport et l'envoie par email (à l'email du user par défaut ou à l'email fourni)."""
    # determine period
    today = datetime.utcnow().date()
    if req.year is None or req.month is None:
        if today.month == 1:
            year = today.year - 1
            month = 12
        else:
            year = today.year
            month = today.month - 1
    else:
        year = req.year
        month = req.month

    to_email = req.email or current_user.email

    try:
        pdf_bytes = generate_monthly_report_bytes(db, current_user, year, month)
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

    ok = send_report_via_email(pdf_bytes, to_email, filename=f"rapport_{year}_{month}.pdf")
    if not ok:
        raise HTTPException(status_code=500, detail="Envoi email échoué")

    return JSONResponse(status_code=200, content={"detail": "Rapport envoyé"})
