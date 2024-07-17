import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

// Stateful widget for a dialog to load files.
class LoadDialog extends StatefulWidget {
  final Function(FileSystemEntity)
      onLoad; // Callback function when a file is selected.

  const LoadDialog({super.key, required this.onLoad});

  @override
  LoadDialogState createState() => LoadDialogState();
}

// State class for the LoadDialog widget.
class LoadDialogState extends State<LoadDialog> {
  List<FileSystemEntity> _files = []; // List to store loaded files.

  @override
  void initState() {
    super.initState();
    _loadFiles(); // Load files when the state is initialized.
  }

  // Method to load files from the application documents directory.
  Future<void> _loadFiles() async {
    final directory = await getApplicationDocumentsDirectory();
    final files = directory
        .listSync()
        .where((item) =>
            item.path.endsWith('.json')) // Filter files with .json extension.
        .toList();
    setState(() {
      _files = files; // Update the list of files.
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Load Drawing'), // Dialog title.
      content: SizedBox(
        width: double.maxFinite,
        height: 200,
        child: ListView.builder(
          itemCount: _files.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(_files[index]
                  .path
                  .split('/')
                  .last
                  .replaceAll('.json', '')), // Display file name.
              onTap: () {
                widget
                    .onLoad(_files[index]); // Callback when a file is selected.
                Navigator.of(context).pop(); // Close the dialog.
              },
            );
          },
        ),
      ),
      actions: [
        TextButton(
          child: const Text('Cancel'), // Cancel button to close the dialog.
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}
