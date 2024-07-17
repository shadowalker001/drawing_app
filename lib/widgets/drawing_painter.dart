import 'package:drawing_app/providers/drawing_provider.dart';
import 'package:flutter/material.dart';

// Custom painter for drawing on the canvas.
class DrawingPainter extends CustomPainter {
  final DrawingState drawingState; // State of the drawing.
  final String selectedFont; // Currently selected font.

  // Constructor to initialize the drawing state and selected font.
  DrawingPainter(this.drawingState, this.selectedFont);

  @override
  void paint(Canvas canvas, Size size) {
    // If a background image is set, draw it on the canvas.
    if (drawingState.backgroundImage != null) {
      paintImage(
        canvas: canvas,
        image: drawingState.backgroundImage!,
        rect: Rect.fromLTWH(0, 0, size.width, size.height),
        fit: BoxFit.cover,
      );
    } else {
      // If no background image, fill the canvas with the background color.
      canvas.drawColor(drawingState.backgroundColor, BlendMode.srcOver);
    }

    // Draw each line in the drawing state.
    for (final line in drawingState.lines) {
      final paint = Paint()
        ..color = line.color // Set the color of the paint.
        ..strokeCap = StrokeCap.round // Set the stroke cap to round.
        ..strokeWidth = line.width; // Set the stroke width.

      // Draw the line by connecting each point.
      for (int i = 0; i < line.points.length - 1; i++) {
        canvas.drawLine(line.points[i], line.points[i + 1], paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // Repaint whenever there is a change.
    return true;
  }
}
