import os
import openai
from dotenv import load_dotenv
from Database import database

load_dotenv(override=True)

#gather API key from .env file. Make sure to update your personal API key in the .env file for now.
openai.api_key  = os.getenv('API_KEY')

#API function
def getAPI(query):
    chat_completion = openai.ChatCompletion.create(
            model="gpt-3.5-turbo", 
            messages=[{"role": "user", "content": query}]
            )
    filtered = chat_completion.choices[0].message.content
    print("A ", filtered)

    return filtered

#while loop to allow ongoing conversation with GPT api - Type "exit" to break loop
while True:
    message = input('Q: ')
    if message == "exit":
        break
    else:
        #call API function and pass user question as parameter
        gptResponse = getAPI(message)
        print("gpt response: ", gptResponse)

        # Call database execute function
        # Parameters : UserID, User question, GPT answer
        # Change UserID to your number 1-5
        database.executeFunction(5, message, gptResponse)

