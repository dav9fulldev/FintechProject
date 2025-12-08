from sqlalchemy import create_engine, text
import os
from dotenv import load_dotenv

load_dotenv()

DATABASE_URL = os.getenv("DATABASE_URL")

if not DATABASE_URL:
    raise ValueError("❌ DATABASE_URL non défini dans .env")

engine = create_engine(DATABASE_URL)

with engine.connect() as conn:
    result = conn.execute(
        text("""
            SELECT id, email, username, first_name, last_name, phone 
            FROM users 
            WHERE email = :email
        """),
        {"email": "broudavidyao51@gmail.com"}
    ).fetchone()
    
    if result:
        print('=== User data ===')
        print(f'ID: {result[0]}')
        print(f'Email: {result[1]}')
        print(f'Username: {result[2]}')
        print(f'First Name: "{result[3]}"')
        print(f'Last Name: "{result[4]}"')
        print(f'Phone: "{result[5]}"')
        
        if not result[3]:
            print('\n⚠️ First Name is empty or NULL')
        else:
            print(f'\n✅ First Name exists: {result[3]}')
    else:
        print('User not found')