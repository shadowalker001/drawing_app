import 'package:flutter/material.dart';

// A widget that displays a font option with selection state.
class FontOption extends StatelessWidget {
  final bool isSelected; // Indicates if the font option is currently selected.
  final VoidCallback onTap; // Callback function to handle tap events.
  final String label; // Label to display for the font option.

  const FontOption({
    super.key,
    required this.isSelected,
    required this.onTap,
    required this.label,
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
              ? Colors.blue.withOpacity(0.3)
              : Colors
                  .transparent, // Background color based on selection state.
          borderRadius: BorderRadius.circular(8.0), // Rounded corners.
          border: Border.all(
            color: isSelected
                ? Colors.blue
                : Colors
                    .grey.shade300, // Border color based on selection state.
            width: 2,
          ),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.blue, // Circle avatar background color.
              radius: 16.0, // Radius of the circle avatar.
              child: isSelected
                  ? const Icon(Icons.check,
                      color: Colors.white,
                      size: 18.0) // Check icon if selected.
                  : Container(), // Empty container if not selected.
            ),
            const SizedBox(width: 16.0), // Spacing between the avatar and text.
            Text(
              label, // Display the label text.
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
}
