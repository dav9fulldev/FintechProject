from sqlalchemy import create_engine, text

# Connexion directe à la base de données
engine = create_engine('postgresql://postgres:postgres@localhost:5432/gertonargent')

with engine.connect() as conn:
    result = conn.execute(text("SELECT id, email, username, first_name, last_name, phone FROM users WHERE email = 'broudavidyao51@gmail.com'")).fetchone()
    
    if result:
        print('=== User data ===')
        print(f'ID: {result[0]}')
        print(f'Email: {result[1]}')
        print(f'Username: {result[2]}')
        print(f'First Name: "{result[3]}"')
        print(f'Last Name: "{result[4]}"')
        print(f'Phone: "{result[5]}"')
        
        if result[3] is None or result[3] == '':
            print('\n⚠️  First Name is empty or NULL')
        else:
            print(f'\n✅ First Name exists: {result[3]}')
    else:
        print('User not found')
