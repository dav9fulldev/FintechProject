from datetime import datetime, date
from io import BytesIO
import calendar
from reportlab.lib.pagesizes import A4
from reportlab.pdfgen import canvas
from sqlalchemy.orm import Session
from ..models.transaction import Transaction
from ..models.budget import Budget
from ..models.goal import Goal
from ..models.database import get_db
from email.message import EmailMessage
import smtplib
import os


def _format_currency(amount: float) -> str:
    return f"{amount:,.2f}"


def _get_month_range(year: int, month: int):
    start = datetime(year, month, 1)
    last_day = calendar.monthrange(year, month)[1]
    end = datetime(year, month, last_day, 23, 59, 59)
    return start, end


def generate_monthly_report_bytes(db: Session, user, year: int, month: int) -> bytes:
    """Génère un PDF en mémoire pour l'utilisateur et la période donnée."""
    start, end = _get_month_range(year, month)

    # Récupérer transactions, budgets, goals
    transactions = (
        db.query(Transaction)
        .filter(Transaction.user_id == user.id)
        .filter(Transaction.created_at >= start)
        .filter(Transaction.created_at <= end)
        .order_by(Transaction.created_at)
        .all()
    )

    budgets = db.query(Budget).filter(Budget.user_id == user.id).all()
    goals = db.query(Goal).filter(Goal.user_id == user.id).all()

    total_income = sum(t.amount for t in transactions if t.transaction_type != "expense")
    total_expense = sum(t.amount for t in transactions if t.transaction_type == "expense")

    # Top categories
    category_sums = {}
    for t in transactions:
        cat = getattr(t.category, 'value', str(t.category))
        category_sums[cat] = category_sums.get(cat, 0) + (t.amount if t.transaction_type == 'expense' else 0)
    top_categories = sorted(category_sums.items(), key=lambda x: x[1], reverse=True)[:5]

    buffer = BytesIO()
    c = canvas.Canvas(buffer, pagesize=A4)
    width, height = A4

    # Header
    c.setFont("Helvetica-Bold", 18)
    c.drawString(40, height - 60, f"GèrTonArgent - Rapport mensuel")
    c.setFont("Helvetica", 12)
    c.drawString(40, height - 80, f"Utilisateur: {user.username} ({user.email})")
    c.drawString(40, height - 100, f"Période: {start.strftime('%Y-%m-%d')} → {end.strftime('%Y-%m-%d')}")

    y = height - 140

    # Summary
    c.setFont("Helvetica-Bold", 14)
    c.drawString(40, y, "Résumé")
    y -= 20
    c.setFont("Helvetica", 12)
    c.drawString(50, y, f"Revenus totaux: { _format_currency(total_income) }")
    y -= 18
    c.drawString(50, y, f"Dépenses totales: { _format_currency(total_expense) }")
    y -= 24

    # Top categories
    c.setFont("Helvetica-Bold", 14)
    c.drawString(40, y, "Top catégories (dépenses)")
    y -= 20
    c.setFont("Helvetica", 12)
    if top_categories:
        for cat, amt in top_categories:
            c.drawString(50, y, f"- {cat}: { _format_currency(amt) }")
            y -= 16
            if y < 80:
                c.showPage()
                y = height - 60
    else:
        c.drawString(50, y, "Aucune dépense enregistrée pour cette période.")
        y -= 20

    # Budgets
    c.setFont("Helvetica-Bold", 14)
    c.drawString(40, y, "Budgets")
    y -= 20
    c.setFont("Helvetica", 12)
    if budgets:
        for b in budgets:
            c.drawString(50, y, f"- {b.category.value}: Limite mensuelle { _format_currency(b.monthly_limit) }, Dépensé { _format_currency(b.current_spent) }")
            y -= 16
            if y < 80:
                c.showPage()
                y = height - 60
    else:
        c.drawString(50, y, "Aucun budget défini.")
        y -= 20

    # Goals
    c.setFont("Helvetica-Bold", 14)
    c.drawString(40, y, "Objectifs")
    y -= 20
    c.setFont("Helvetica", 12)
    if goals:
        for g in goals:
            progress = (g.current_amount / g.target_amount * 100) if g.target_amount else 0
            c.drawString(50, y, f"- {g.name}: { _format_currency(g.current_amount) } / { _format_currency(g.target_amount) } ({progress:.1f}%)")
            y -= 16
            if y < 80:
                c.showPage()
                y = height - 60
    else:
        c.drawString(50, y, "Aucun objectif défini.")
        y -= 20

    # Transactions list (first 50)
    c.setFont("Helvetica-Bold", 14)
    c.drawString(40, y, "Transactions (extrait)")
    y -= 20
    c.setFont("Helvetica", 10)
    if transactions:
        for t in transactions[:50]:
            ts = t.created_at.strftime('%Y-%m-%d') if t.created_at else ''
            desc = (t.description or '')[:60]
            c.drawString(50, y, f"{ts} | {desc} | {t.transaction_type} | { _format_currency(t.amount) }")
            y -= 12
            if y < 60:
                c.showPage()
                y = height - 60
    else:
        c.drawString(50, y, "Aucune transaction pour cette période.")
        y -= 20

    c.showPage()
    c.save()

    buffer.seek(0)
    return buffer.read()


def send_report_via_email(report_bytes: bytes, to_email: str, filename: str = "report.pdf") -> bool:
    """Envoie le PDF via SMTP. Utilise les variables d'environnement SMTP_*"""
    SMTP_HOST = os.getenv("SMTP_HOST")
    SMTP_PORT = int(os.getenv("SMTP_PORT", 465))
    SMTP_USER = os.getenv("SMTP_USER")
    SMTP_PASS = os.getenv("SMTP_PASS")
    FROM_EMAIL = os.getenv("FROM_EMAIL", SMTP_USER)

    if not SMTP_HOST or not SMTP_USER or not SMTP_PASS:
        return False

    msg = EmailMessage()
    msg["Subject"] = "Votre rapport mensuel GèrTonArgent"
    msg["From"] = FROM_EMAIL
    msg["To"] = to_email
    msg.set_content("Veuillez trouver en pièce jointe votre rapport mensuel.")

    msg.add_attachment(report_bytes, maintype='application', subtype='pdf', filename=filename)

    try:
        # Utilisation TLS/SSL si port 465
        if SMTP_PORT == 465:
            with smtplib.SMTP_SSL(SMTP_HOST, SMTP_PORT) as smtp:
                smtp.login(SMTP_USER, SMTP_PASS)
                smtp.send_message(msg)
        else:
            with smtplib.SMTP(SMTP_HOST, SMTP_PORT) as smtp:
                smtp.starttls()
                smtp.login(SMTP_USER, SMTP_PASS)
                smtp.send_message(msg)
        return True
    except Exception as e:
        print("Erreur envoi email:", e)
        return False
