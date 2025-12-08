"""
Script de migration pour créer la table planned_purchases
"""
import psycopg2
import os
from dotenv import load_dotenv

load_dotenv()

DB_URL = os.getenv("DATABASE_URL", "postgresql://postgres:dav05&ya@localhost:5432/gertonargent")

def create_planned_purchases_table():
    """Créer la table planned_purchases"""
    try:
        conn = psycopg2.connect(DB_URL)
        cur = conn.cursor()
        
        # Créer la table planned_purchases
        cur.execute("""
            CREATE TABLE IF NOT EXISTS planned_purchases (
                id SERIAL PRIMARY KEY,
                user_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
                name VARCHAR NOT NULL,
                description VARCHAR,
                amount DOUBLE PRECISION NOT NULL,
                category VARCHAR NOT NULL,
                planned_date TIMESTAMP,
                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                purchased_at TIMESTAMP,
                status VARCHAR DEFAULT 'pending',
                transaction_id INTEGER REFERENCES transactions(id)
            )
        """)
        
        # Créer les index
        cur.execute("""
            CREATE INDEX IF NOT EXISTS idx_planned_purchases_user_id 
            ON planned_purchases(user_id)
        """)
        
        cur.execute("""
            CREATE INDEX IF NOT EXISTS idx_planned_purchases_status 
            ON planned_purchases(status)
        """)
        
        conn.commit()
        print("✅ Table planned_purchases créée avec succès")
        
        cur.close()
        conn.close()
        
    except Exception as e:
        print(f"❌ Erreur lors de la création de la table: {e}")

if __name__ == "__main__":
    create_planned_purchases_table()
