// Fill out your copyright notice in the Description page of Project Settings.
#include "COMP482.h"
#include "HttpModule.h"
#include "Interfaces/IHttpRequest.h"
#include "Interfaces/IHttpResponse.h"
#include "ChatGPTClient.h"

void UChatGPTClient::SendChatPrompt(const FString& Prompt)
{
     // Replace with your ChatGPT API endpoint
     FString ChatGPTAPIURL = TEXT("YOUR_CHATGPT_API_URL");

     // Construct the HTTP request object
     TSharedRef<IHttpRequest, ESPMode::ThreadSafe> HttpRequest = FHttpModule::Get().CreateRequest();
     HttpRequest->SetURL(ChatGPTAPIURL);
     HttpRequest->SetVerb(TEXT("POST"));
     HttpRequest->SetHeader(TEXT("Authorization"), TEXT("Bearer YOUR_API_KEY"));  // Replace with your API key
     HttpRequest->SetHeader(TEXT("Content-Type"), TEXT("application/json"));
     HttpRequest->SetContentAsString(Prompt);

     // Define the request callback
     HttpRequest->OnProcessRequestComplete().BindStatic([](FHttpRequestPtr Request, FHttpResponsePtr Response, bool bWasSuccessful) {
          if (bWasSuccessful && Response.IsValid() && Response->GetResponseCode() == EHttpResponseCodes::Ok) {
               FString Result = Response->GetContentAsString();
               // Process the ChatGPT response (e.g., display it in your game's chat UI)
               // Here, you can call a function to display the response in your game.
          }
          });

     // Send the request
     HttpRequest->ProcessRequest();
}
