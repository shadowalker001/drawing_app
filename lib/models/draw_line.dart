import 'package:flutter/material.dart';

class DrawnLine {
  final List<Offset> points; // List of points that define the line
  final Color color; // Color of the line
  final double width; // Width of the line

  DrawnLine({
    required this.points,
    required this.color,
    required this.width,
  });

  // Convert DrawnLine object to JSON format
  Map<String, dynamic> toJson() {
    return {
      'points': points
          .map((point) => {'x': point.dx, 'y': point.dy})
          .toList(), // Convert each Offset to Map {'x': dx, 'y': dy}
      'color': color.value, // Store color value as int
      'width': width, // Store width as double
    };
  }

  // Create DrawnLine object from JSON data
  static DrawnLine fromJson(Map<String, dynamic> json) {
    final points = (json['points'] as List)
        .map((pointJson) => Offset(pointJson['x'],
            pointJson['y'])) // Convert each Map {'x': x, 'y': y} to Offset
        .toList();
    final color = Color(json['color']); // Retrieve color from JSON int value
    final width = json['width']; // Retrieve width from JSON double value
    return DrawnLine(points: points, color: color, width: width);
  }
}
