import os
import openai
from dotenv import load_dotenv

load_dotenv()
openai.api_key  = os.getenv('API_KEY')

def getAPI(query):
    chat_completion = openai.ChatCompletion.create(
            model="gpt-3.5-turbo", 
            messages=[{"role": "user", "content": query}]
            )
    filtered = chat_completion.choices[0].message.content
    print("A ", filtered)

while True:
    message = input('Q: ')
    if message == "exit":
        break
    else:
        getAPI(message)