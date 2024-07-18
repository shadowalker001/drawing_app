# Drawing App

A simple drawing application built with Flutter and Riverpod that allows users to draw on a canvas, select colors, choose fonts, and save or load their drawings.

## Features

- Draw lines on a canvas with customizable colors and thickness.
- Select from a variety of fonts.
- Save and load drawings as JSON files.
- Undo the last drawn line.
- Set a background color or image for the canvas.

## Video Demo

<video width="320" height="240" controls>
  <source src="assets/demo/20240717204904.mp4" type="video/mp4">
  Your browser does not support the video tag.
</video>

## Screenshots

![Screenshot 1](assets/screenshots/Screenshot_1721249319.png) ![Screenshot 2](assets/screenshots/Screenshot_1721249336.png) ![Screenshot 3](assets/screenshots/Screenshot_1721249350.png)

![Screenshot 4](assets/screenshots/Screenshot_1721249371.png) ![Screenshot 5](assets/screenshots/Screenshot_1721248832.png)

## Getting Started

### Prerequisites

- Flutter SDK
- Dart SDK

### Installation

1. **Clone the repository:**
    ```bash
    git clone https://github.com/shadowalker001/drawing_app.git
    cd drawing_app
    ```

2. **Install dependencies:**
    ```bash
    flutter pub get
    ```

3. **Run the app:**
    ```bash
    flutter run
    ```

## Project Structure

```plaintext
lib
├── main.dart                 # Entry point of the application
├── models
│   └── draw_line.dart        # Model class for a drawn line
├── providers
│   └── drawing_provider.dart   # State management for drawing
├── screens
│   └── drawing_screen.dart   # Main screen for drawing
├── widgets
    ├── color_option.dart     # Widget for color selection
    ├── drawing_painter.dart  # Custom painter for drawing
    ├── font_option.dart      # Widget for font selection
    ├── load_dialog.dart      # Dialog for loading a drawing
    └── save_dialog.dart      # Dialog for saving a drawing
