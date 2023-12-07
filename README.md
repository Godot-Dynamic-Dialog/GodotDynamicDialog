<img src="https://github.com/Godot-Dynamic-Dialog/UnrealDynamicDialog/assets/60556017/78da47e2-6371-46fe-870e-d026c4585977" width=180 align="right" />

# Godot Dynamic Dialog

Welcome to the Godot Dynamic Dialog project! This innovative system is designed to revolutionize the way dialog is created and presented in gaming. By harnessing the context of a player's environment and the objects within it, our system dynamically generates dialog that is both engaging and relevant, offering a unique narrative experience every time.

## Table of Contents

- [Introduction](#introduction)
- [Features](#features)
- [Technology Stack](#technology-stack)
- [Installation](#installation)
- [Project Structure](#project-structure)
- [Documentation](#documentation)
- [References](#references)
- [License](#license)

## Introduction

In the realm of interactive storytelling, dialog plays a crucial role in immersing players in the game world. Godot Dynamic Dialog takes this immersion to the next level by dynamically generating dialog based on the player's immediate surroundings and interactions. This allows for a fluid and evolving narrative, tailored to each player's unique journey through the game world.

## Features

- **Context-Aware Dialog**: Generate dialog that responds to the player's environment and actions.
- **Diverse Narrative Possibilities**: Endless narrative options as dialog adapts to various in-game scenarios.
- **Real-Time Updates**: Dialog evolves in real-time, reflecting the dynamic nature of gameplay.

## Technology Stack

Godot Dynamic Dialog is built upon a robust selection of technologies, each chosen to deliver the best possible experience:

- [**Godot Engine**](https://godotengine.org/): For game development and immersive experiences.
- [**GD Script**](https://docs.godotengine.org/en/stable/getting_started/scripting/gdscript/gdscript_basics.html): For scripting in Godot Engine.
- [**HTTPSSE Client**](https://docs.godotengine.org/en/stable/classes/class_httpclient.html): For real-time communication between Godot Engine and OpenAI API.
- [**OpenAI API**](https://openai.com/blog/openai-api): Utilized for advanced natural language processing to generate dialog.

## Installation

To get started with Godot Dynamic Dialog, please follow our [`/Docs/Installation.md`](./Docs/Installation.md). This guide will walk you through the process of setting up the project on your local machine.

## Project Structure

Our project is structured as follows:

**`/addons`**: Contains Godot Engine addons used in the project. This includes the HTTPSSE Client.

**`/Assets`**: Contains all assets used in the project. This includes our sprites, fonts, and other resources.

**`/Database`**: Contains the depreciated SQL database schema scripts. These will be implemented in the future if we decide to use a SQL database.

**`/Docs`**: Contains all documentation for the project. This includes references and development guides.

**`/DialogueManager`**: Contains the scripts and JSON Objects used in the dialogue system.

**`/Scenes`**: Contains the scenes used in the project. Each scene contains its corresponding scripts alongside it.

## Documentation

For more information on how to use Godot Dynamic Dialog, including installation guides and references, please check out the [`/Docs`](./Docs/) Folder.

## References

Checkout the [`/Docs/References.md`](./Docs/References.md) file for a list of all the assets and references used in this project.

## License

This project is licensed under the [MIT License](/LICENSE.md) - see the license file for details.
