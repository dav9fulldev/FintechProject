"""
Migration script to add new fields to users table
"""
from sqlalchemy import create_engine, text
import os
from dotenv import load_dotenv

load_dotenv()

DATABASE_URL = os.getenv("DATABASE_URL", "postgresql://postgres:dav05&ya@localhost:5432/gertonargent")

engine = create_engine(DATABASE_URL)

# SQL statements to add columns
migrations = [
    "ALTER TABLE users ADD COLUMN IF NOT EXISTS first_name VARCHAR",
    "ALTER TABLE users ADD COLUMN IF NOT EXISTS last_name VARCHAR",
    "ALTER TABLE users ADD COLUMN IF NOT EXISTS profession VARCHAR",
    "ALTER TABLE users ADD COLUMN IF NOT EXISTS income_range VARCHAR"
]

with engine.connect() as conn:
    for sql in migrations:
        try:
            conn.execute(text(sql))
            print(f"✅ Executed: {sql}")
        except Exception as e:
            print(f"❌ Error: {sql} - {e}")
    
    conn.commit()
    print("\n✅ Migration completed!")
