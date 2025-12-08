from sqlalchemy import create_engine, text
import os
from dotenv import load_dotenv

DATABASE_URL = os.getenv("DATABASE_URL")
engine = create_engine(DATABASE_URL)

with engine.connect() as conn:
    conn.execute(text("ALTER TABLE transactions ADD COLUMN IF NOT EXISTS transaction_type VARCHAR DEFAULT 'expense'"))
    conn.commit()
    print("✅ Colonne transaction_type ajoutée")
