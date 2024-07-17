import 'package:flutter/material.dart';

// Stateful widget for a dialog to save a drawing.
class SaveDialog extends StatefulWidget {
  final Function(String) onSave; // Callback function when saving the file.

  const SaveDialog({super.key, required this.onSave});

  @override
  SaveDialogState createState() => SaveDialogState();
}

// State class for the SaveDialog widget.
class SaveDialogState extends State<SaveDialog> {
  final TextEditingController _controller =
      TextEditingController(); // Controller for the text field.

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Save Drawing'), // Dialog title.
      content: TextField(
        controller:
            _controller, // Text field controller to capture file name input.
        decoration: const InputDecoration(
            hintText: 'Enter file name'), // Placeholder text in the text field.
      ),
      actions: [
        TextButton(
          child: const Text('Cancel'), // Cancel button to close the dialog.
          onPressed: () => Navigator.of(context).pop(),
        ),
        TextButton(
          child: const Text('Save'), // Save button to trigger saving the file.
          onPressed: () {
            if (_controller.text.isEmpty) return;
            widget.onSave(_controller
                .text); // Invoke onSave callback with the entered file name.
            Navigator.of(context).pop(); // Close the dialog.
          },
        ),
      ],
    );
  }
}
