// Fill out your copyright notice in the Description page of Project Settings.

#pragma once

#include "CoreMinimal.h"

/**
 *
 */

UCLASS()
class COMP482_API UChatGPTClient : public UObject
{
	GENERATED_BODY()
public:
	UFUNCTION(BlueprintCallable, Category = "ChatGPT")
	static void SendChatPrompt(const FString& Prompt);
};
