import pyodbc
import os
from dotenv import load_dotenv

load_dotenv()

# Set up your connection variables
driver = '{ODBC Driver 13 for SQL Server}'
server = os.getenv('DATABASE_SERVER')
database = os.getenv('DATABASE_NAME')
username = os.getenv('DATABASE_USERNAME')
password = os.getenv('DATABASE_PASSWORD')

# Create a connection string
connection_string = f'DRIVER={driver};SERVER={server};DATABASE={database};UID={username};PWD={password}'

# Connect to your database
conn = pyodbc.connect(connection_string)
cursor = conn.cursor()

# SQL command to INSERT a row into promptHistory
insert_command = '''
INSERT INTO promptHistory (userId, promptText, createdAt)
VALUES (?, ?, GETDATE());
'''

# Data to insert
user_id = 1
prompt_text = 'This is from the python file!'

# Execute the INSERT command
cursor.execute(insert_command, (user_id, prompt_text))

# Commit the transaction
conn.commit()

# Close the cursor and connection
cursor.close()
conn.close()

print("Data inserted successfully!")