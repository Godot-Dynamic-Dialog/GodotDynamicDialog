import os
import openai

API_KEY = open("API_KEY.txt", "r").read()
openai.api_key  = API_KEY

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