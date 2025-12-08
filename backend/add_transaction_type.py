from sqlalchemy import create_engine, text

DATABASE_URL = "postgresql://postgres:dav05&ya@localhost:5432/gertonargent"
engine = create_engine(DATABASE_URL)

with engine.connect() as conn:
    conn.execute(text("ALTER TABLE transactions ADD COLUMN IF NOT EXISTS transaction_type VARCHAR DEFAULT 'expense'"))
    conn.commit()
    print("✅ Colonne transaction_type ajoutée")
