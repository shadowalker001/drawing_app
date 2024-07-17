import 'package:flutter/material.dart';

// A widget that displays a color option with optional label and selection state.
class ColorOption extends StatelessWidget {
  final Color color; // The color option to display.
  final bool isSelected; // Indicates if the color is currently selected.
  final VoidCallback onTap; // Callback function to handle tap events.
  final String label; // Optional label for more context.

  const ColorOption({
    super.key,
    required this.color,
    required this.isSelected,
    required this.onTap,
    this.label = '', // Default empty label.
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Handles tap events.
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0), // Vertical margin.
        padding: const EdgeInsets.symmetric(
            vertical: 12.0, horizontal: 16.0), // Padding inside the container.
        decoration: BoxDecoration(
          color: isSelected
              ? color.withOpacity(0.3)
              : Colors
                  .transparent, // Background color based on selection state.
          borderRadius: BorderRadius.circular(8.0), // Rounded corners.
          border: Border.all(
            color: isSelected
                ? color
                : Colors
                    .grey.shade300, // Border color based on selection state.
            width: 2,
          ),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: color, // Background color of the circle avatar.
              radius: 16.0, // Radius of the circle avatar.
              child: isSelected
                  ? const Icon(Icons.check,
                      color: Colors.white,
                      size: 18.0) // Check icon if selected.
                  : Container(), // Empty container if not selected.
            ),
            const SizedBox(width: 16.0), // Spacing between the avatar and text.
            Text(
              label.isNotEmpty
                  ? label
                  : colorToString(
                      color), // Display the label or the color name.
              style: TextStyle(
                fontSize: 16.0, // Font size.
                color: isSelected
                    ? Colors.black
                    : Colors
                        .grey.shade600, // Text color based on selection state.
                fontWeight: isSelected
                    ? FontWeight.bold
                    : FontWeight
                        .normal, // Font weight based on selection state.
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Converts a Color to a readable string.
  String colorToString(Color color) {
    if (color == Colors.white) return "White";
    if (color == Colors.red) return "Red";
    if (color == Colors.green) return "Green";
    if (color == Colors.blue) return "Blue";
    return "Custom Color";
  }
}
