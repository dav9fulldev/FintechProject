import os
from dotenv import load_dotenv
import sqlalchemy
import sys

print(f"Python encoding: {sys.getdefaultencoding()}")
print(f"Filesystem encoding: {sys.getfilesystemencoding()}")

load_dotenv()
db_url = os.getenv("DATABASE_URL")
if not db_url:
    print("DATABASE_URL is None!")
    sys.exit(1)

print(f"URL length: {len(db_url)}")
try:
    print(f"URL as UTF-8: {db_url.encode('utf-8').decode('utf-8')}")
except Exception as e:
    print(f"UTF-8 error: {e}")

# Check for non-ascii characters
for i, char in enumerate(db_url):
    if ord(char) > 127:
        print(f"Non-ASCII char at pos {i}: {char} (ord: {ord(char)})")

try:
    engine = sqlalchemy.create_engine(db_url)
    with engine.connect() as conn:
        print("Connection successful!")
except Exception as e:
    print(f"Connection error: {type(e).__name__}: {e}")
