# Recipes

This project is a recipe management application built using Swift. The primary purpose of this application is to provide users with a seamless experience to manage their favorite recipes. The project follows the Model-View (MV) architectural pattern, which helps in maintaining a clean and organized codebase.

## Table of Contents
- [Recipes](#recipes)
  - [Table of Contents](#table-of-contents)
  - [Introduction](#introduction)
  - [Architecture](#architecture)
  - [Features](#features)
  - [Setup and Installation](#setup-and-installation)

## Introduction

The Recipes application allows users to add and delete recipes. Users can also categorize recipes and search for specific recipes based on ingredients or recipe names. 

## Architecture

The project follows the Model-View (MV) architectural pattern. Here's a detailed overview of how each component is structured:

- **Model**: The Model layer consists of aggregate classes responsible for managing the entire app state. These classes handle data operations such as fetching, storing, and updating recipes. Models in this project are designed to encapsulate business logic and data manipulation, ensuring that the app state is consistently managed across the application.

- **View**: The View layer comprises the user interface components that display data to the user and handle user interactions. Views are designed to be as simple as possible, focusing solely on presenting data and forwarding user actions to the appropriate models. This separation ensures that the UI remains decoupled from the business logic.

## Features

The Recipes app includes the following features:

1. **Home Screen**:
   - Displays a list of recipes.
   - Provides a search functionality to filter recipes by name or ingredients.
   - Shows a thumbnail image and the name of each recipe.

2. **Detail Screen**:
   - Displays detailed information about a selected recipe.
   - Shows a larger image of the recipe, the name, and a detailed description.
   - Includes a button to navigate to the Map Screen.

3. **Map Screen**:
   - Shows the geographical origin of the selected recipe on a map.
   - Displays a marker indicating the location of the recipe's origin.

4. **Recipe Management / Add Recipe Screen**:
   - Allows users to add new recipes to their collection.
   - Allows users to delete recipes from their collection.
5. **Local or Remote data fetching**
   - The source of the data can be changed by just modifying one line in the code. Default sourcing is local.
   - The code for a small server application is also included. Check Setup and Installation for more info.

These features ensure that users can easily browse, search, and view detailed information about their favorite recipes, as well as learn about their geographical origins. Additionally, the app provides basic recipe management functionality.

## Setup and Installation

To set up and run the Recipes application, follow these steps:

1. Open the Xcode workspace. Wait for dependencies to be fetched.
2. Build and run the `RecipesApp` scheme. App will fetch data from a local json file by default.
3. (Optional - Execute local server app) Run the RecipesServer scheme. Server will start listening on `http://localhost:8080`. In the RecipesApp folder do the following and re-run the `RecipesApp` scheme:
``` swift
// RecipesApp.swift
class RecipesApp {
   // Replace this:
   let source = DataSource.local
   // With this:
   let source = DataSource.remote
}
```