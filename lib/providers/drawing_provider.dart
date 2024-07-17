import 'dart:convert';
import 'dart:io';

import 'package:drawing_app/models/draw_line.dart'; // Import your DrawnLine model.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Import Riverpod for state management.
import 'dart:ui' as ui;

import 'package:path_provider/path_provider.dart'; // Import path_provider for file handling.

// Define a StateNotifierProvider for managing the drawing state.
final drawingProvider =
    StateNotifierProvider<DrawingNotifier, DrawingState>((ref) {
  return DrawingNotifier();
});

// Class representing the state of the drawing application.
class DrawingState {
  final List<DrawnLine> lines; // List of lines drawn.
  final Color backgroundColor; // Background color of the drawing canvas.
  final ui.Image? backgroundImage; // Optional background image of the canvas.
  final Color selectedColor; // Currently selected drawing color.
  final String selectedFont; // Currently selected font for text drawing.
  final double selectedThickness; // Currently selected drawing thickness.

  DrawingState({
    required this.lines,
    required this.backgroundColor,
    this.backgroundImage,
    required this.selectedColor,
    required this.selectedFont,
    required this.selectedThickness,
  });

  // Method to create a copy of the state with optional changes.
  DrawingState copyWith({
    List<DrawnLine>? lines,
    Color? backgroundColor,
    ui.Image? backgroundImage,
    Color? selectedColor,
    String? selectedFont,
    double? selectedThickness,
    bool forceBg = false, // Optional flag to force update background image.
  }) {
    return DrawingState(
      lines: lines ?? this.lines,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      backgroundImage:
          forceBg ? backgroundImage : (backgroundImage ?? this.backgroundImage),
      selectedColor: selectedColor ?? this.selectedColor,
      selectedFont: selectedFont ?? this.selectedFont,
      selectedThickness: selectedThickness ?? this.selectedThickness,
    );
  }

  // Method to convert the state to JSON format for serialization.
  Map<String, dynamic> toJson() {
    return {
      'lines': lines.map((line) => line.toJson()).toList(),
      'backgroundColor': backgroundColor.value,
      'selectedColor': selectedColor.value,
      'selectedFont': selectedFont,
      'selectedThickness': selectedThickness,
    };
  }

  // Static method to create a DrawingState object from JSON data.
  static DrawingState fromJson(Map<String, dynamic> json) {
    final lines = (json['lines'] as List)
        .map((lineJson) => DrawnLine.fromJson(lineJson))
        .toList();
    final backgroundColor =
        Color(json['backgroundColor'] ?? Colors.white.value);
    final selectedColor = Color(json['selectedColor'] ?? Colors.black.value);
    final selectedFont = json['selectedFont'] ?? 'Roboto';
    final selectedThickness = json['selectedThickness'] ?? 2.0;
    return DrawingState(
      lines: lines,
      backgroundColor: backgroundColor,
      selectedColor: selectedColor,
      backgroundImage: null,
      selectedFont: selectedFont,
      selectedThickness: selectedThickness,
    );
  }
}

// StateNotifier class for managing updates to the DrawingState.
class DrawingNotifier extends StateNotifier<DrawingState> {
  DrawingNotifier()
      : super(DrawingState(
          lines: [],
          backgroundColor: Colors.white,
          selectedColor: Colors.black,
          backgroundImage: null,
          selectedFont: 'Roboto',
          selectedThickness: 2.0,
        ));

  // Method to start a new drawing line.
  void startLine(DrawnLine line) {
    state = state.copyWith(lines: [...state.lines, line]);
  }

  // Method to update the current drawing line with new points.
  void updateLine(Offset point) {
    final lines = List<DrawnLine>.from(state.lines);
    final lastLine = lines.removeLast();
    final updatedLine = DrawnLine(
      points: [...lastLine.points, point],
      color: lastLine.color,
      width: lastLine.width,
    );
    state = state.copyWith(lines: [...lines, updatedLine]);
  }

  // Method to clear all lines from the canvas.
  void clearCanvas() {
    state = state.copyWith(lines: []);
  }

  // Method to set the background color of the canvas.
  void setBackgroundColor(Color color) {
    state = state.copyWith(
        backgroundColor: color, backgroundImage: null, forceBg: true);
  }

  // Method to set a background image for the canvas.
  void setBackgroundImage(ui.Image image) {
    state = state.copyWith(backgroundImage: image);
  }

  // Method to undo the last drawn line.
  void undoLastLine() {
    if (state.lines.isNotEmpty) {
      state.lines.removeLast();
      state = state.copyWith(lines: state.lines);
    }
  }

  // Method to set the currently selected drawing color.
  void setSelectedColor(Color color) {
    state = state.copyWith(selectedColor: color);
  }

  // Method to set the currently selected font for text drawing.
  void setFont(String selectedFont) {
    state = state.copyWith(selectedFont: selectedFont);
  }

  // Method to set the currently selected drawing thickness.
  void setDrawingThickness(double val) {
    state = state.copyWith(selectedThickness: val);
  }

  // Method to save the current drawing state to a JSON file.
  Future<void> saveDrawing(String fileName) async {
    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/$fileName.json';
    final file = File(path);
    final json = jsonEncode(state.toJson());
    await file.writeAsString(json);
  }

  // Method to load a drawing state from a JSON file.
  Future<void> loadDrawing(FileSystemEntity fileName) async {
    final file = File(fileName.path);
    final json = await file.readAsString();
    final drawingState = DrawingState.fromJson(jsonDecode(json));
    state = drawingState;
  }
}
