# Installation Guide for Godot Dynamic Dialog

This guide will walk you through the process of setting up Godot Dynamic Dialog on your local machine. We assume that you will be using Windows for this process. If you are using a different operating system, please refer to the [Godot Engine Documentation](https://docs.godotengine.org/en/stable/index.html) for more information.

> :warning: **Note**: You will need to obtain an OpenAI API Key for this project to work. You can do so by signing up for the [OpenAI API](https://openai.com/blog/openai-api).

1. **Installing Godot Engine**

   Install [Godot Engine](https://godotengine.org/download/archive/) with .NET Support (C# Version). We recommend using version [4.1.2 Stable .NET](https://godotengine.org/download/archive/4.1.2-stable/) since we used that for the development process.

   > We know C# is not currently active in the project but we have plans to implement it in the future with the SQL Database. You can install the regular version but know you may have to do some extra work to get it to work.

2. **Obtain OpenAI API Key**

   Obtain an OpenAI API Key by signing up for the [OpenAI API](https://openai.com/blog/openai-api).

   > **Note**: You will need to provide a credit card to sign up for the OpenAI API. However, you will not be charged unless you exceed the free tier usage limits.

3. **Add OpenAI API Key to Environment Variables**

   Add your OpenAI API Key to your environment variables. You can do so by following the steps below:

   - Open the Start Menu and search for "Environment Variables".
   - Click on "Edit the system environment variables".
   - Click on "Environment Variables...".
   - Under "System Variables", click on "New...".
   - Enter "OPENAI_API_KEY" for the variable name.
   - Enter your OpenAI API Key for the variable value.
   - Click "OK" to save your changes.

   If you are having trouble adding your OpenAI API Key to your environment variables, please restart Godot Engine after adding the key to your environment variables if you had it opened. This should resolve any issues.

   > **Note**: You can add your OpenAI API Key into PromptInput.gd if you do not want to add it to your environment variables. However, this is not recommended since it is not secure and will be visible to anyone who has access to the project.

4. **Clone the Repository**

   Clone the repository to your local machine.

   ```bash
   git clone https://github.com/Godot-Dynamic-Dialog/GodotDynamicDialog.git
   ```

5. **Adding the Project to Godot Engine**

   Open Godot Engine and click on "Import". Navigate to the repository folder and select the "project.godot" file. Click on "Import & Edit" to open the project.

6. **Running the Project**

   You can run the project by clicking on the "Play" button in the top right corner of the Godot Engine window.

   > **Note**: You will need to have an internet connection to run the project. This is because the project uses the OpenAI API to generate dialog.
