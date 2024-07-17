import 'dart:async'; // Importing dart:async for asynchronous programming.
import 'package:drawing_app/models/draw_line.dart'; // Importing the DrawLine model.
import 'package:drawing_app/widgets/color_option.dart'; // Importing the ColorOption widget.
import 'package:drawing_app/widgets/drawing_painter.dart'; // Importing the DrawingPainter widget.
import 'package:drawing_app/widgets/font_option.dart'; // Importing the FontOption widget.
import 'package:drawing_app/widgets/load_dialog.dart'; // Importing the LoadDialog widget.
import 'package:drawing_app/widgets/save_dialog.dart'; // Importing the SaveDialog widget.
import 'package:flutter/material.dart'; // Importing Flutter material package for UI components.
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Importing Riverpod for state management.
import 'package:flutter/services.dart'; // Importing Flutter services package.
import 'package:image_picker/image_picker.dart'; // Importing image_picker for picking images.
import 'dart:ui' as ui; // Importing ui library with alias for drawing.
import '../providers/drawing_provider.dart'; // Importing drawing provider for state management.

class DrawingScreen extends ConsumerWidget {
  const DrawingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final drawingState =
        ref.watch(drawingProvider); // Watching the drawing state.

    return Scaffold(
      appBar: AppBar(
        title: const Text('Drawing App'), // Setting the app bar title.
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return SaveDialog(
                    onSave: (fileName) {
                      ref.read(drawingProvider.notifier).saveDrawing(
                          fileName); // Save the drawing with the provided file name.
                    },
                  );
                },
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.folder_open),
            onPressed: () async {
              showDialog(
                context: context,
                builder: (context) {
                  return LoadDialog(
                    onLoad: (fileSystem) {
                      ref.read(drawingProvider.notifier).loadDrawing(
                          fileSystem); // Load a drawing from the file system.
                    },
                  );
                },
              );
            },
          ),
        ],
      ),
      body:
          const DrawingCanvas(), // Setting the main body to the DrawingCanvas widget.
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.color_lens),
              onPressed: () {
                showColorPicker(
                    context, ref, drawingState); // Show color picker dialog.
              },
            ),
            IconButton(
              icon: const Icon(Icons.image),
              onPressed: () async {
                final ImagePicker picker =
                    ImagePicker(); // Initialize the image picker.
                final XFile? image = await picker.pickImage(
                    source:
                        ImageSource.gallery); // Pick an image from the gallery.

                if (image != null) {
                  final Uint8List bytes =
                      await image.readAsBytes(); // Read the image bytes.
                  final ui.Image uiImage = await loadImage(Uint8List.view(
                      bytes.buffer)); // Load the image into a ui.Image.
                  ref
                      .read(drawingProvider.notifier)
                      .setBackgroundImage(uiImage); // Set the background image.
                }
              },
            ),
            IconButton(
              icon: const Icon(Icons.undo),
              onPressed: () {
                ref
                    .read(drawingProvider.notifier)
                    .undoLastLine(); // Undo the last line drawn.
              },
            ),
            IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                ref
                    .read(drawingProvider.notifier)
                    .clearCanvas(); // Clear the canvas.
              },
            ),
            IconButton(
              icon: const Icon(Icons.font_download),
              onPressed: () {
                showFontPicker(
                    context, ref, drawingState); // Show font picker dialog.
              },
            ),
          ],
        ),
      ),
    );
  }

  // Function to load an image from bytes.
  Future<ui.Image> loadImage(Uint8List img) async {
    final Completer<ui.Image> completer = Completer();
    ui.decodeImageFromList(img, (ui.Image img) {
      return completer.complete(img);
    });
    return completer.future;
  }

  // Function to show color picker dialog.
  void showColorPicker(
      BuildContext context, WidgetRef ref, DrawingState drawingState) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (BuildContext context) {
        return SizedBox(
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    'Select Drawing Color',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                ColorOption(
                  color: Colors.red,
                  isSelected: drawingState.selectedColor == Colors.red,
                  onTap: () {
                    ref.read(drawingProvider.notifier).setSelectedColor(
                        Colors.red); // Set selected color to red.
                    Navigator.of(context).pop();
                  },
                ),
                ColorOption(
                  color: Colors.green,
                  isSelected: drawingState.selectedColor == Colors.green,
                  onTap: () {
                    ref.read(drawingProvider.notifier).setSelectedColor(
                        Colors.green); // Set selected color to green.
                    Navigator.of(context).pop();
                  },
                ),
                ColorOption(
                  color: Colors.blue,
                  isSelected: drawingState.selectedColor == Colors.blue,
                  onTap: () {
                    ref.read(drawingProvider.notifier).setSelectedColor(
                        Colors.blue); // Set selected color to blue.
                    Navigator.of(context).pop();
                  },
                ),
                const Divider(),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    'Select Background Color',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                ColorOption(
                  color: Colors.white,
                  isSelected: drawingState.backgroundColor == Colors.white,
                  onTap: () {
                    ref.read(drawingProvider.notifier).setBackgroundColor(
                        Colors.white); // Set background color to white.
                    Navigator.of(context).pop();
                  },
                ),
                ColorOption(
                  color: Colors.green,
                  isSelected: drawingState.backgroundColor == Colors.green,
                  onTap: () {
                    ref.read(drawingProvider.notifier).setBackgroundColor(
                        Colors.green); // Set background color to green.
                    Navigator.of(context).pop();
                  },
                ),
                ColorOption(
                  color: Colors.blue,
                  isSelected: drawingState.backgroundColor == Colors.blue,
                  onTap: () {
                    ref.read(drawingProvider.notifier).setBackgroundColor(
                        Colors.blue); // Set background color to blue.
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Function to show font picker dialog.
  void showFontPicker(
      BuildContext context, WidgetRef ref, DrawingState drawingState) {
    double selectedThickness = drawingState.selectedThickness;
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SizedBox(
              height: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: Text(
                        'Select Drawing Thickness',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Slider(
                      activeColor: Colors.blue,
                      inactiveColor: Colors.blue.withOpacity(0.3),
                      value: selectedThickness,
                      min: 1.0,
                      max: 10.0,
                      divisions: 9,
                      label: selectedThickness.toString(),
                      onChanged: (double value) {
                        setState(() {
                          selectedThickness = value;
                          ref
                              .read(drawingProvider.notifier)
                              .setDrawingThickness(
                                  value); // Set drawing thickness.
                        });
                      },
                    ),
                    const Divider(),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: Text(
                        'Select Font',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    FontOption(
                      label: 'Roboto',
                      isSelected: drawingState.selectedFont == 'Roboto',
                      onTap: () {
                        ref
                            .read(drawingProvider.notifier)
                            .setFont('Roboto'); // Set font to Roboto.
                        Navigator.of(context).pop();
                      },
                    ),
                    FontOption(
                      label: 'Edu Australia',
                      isSelected: drawingState.selectedFont == 'Edu_Australia',
                      onTap: () {
                        ref.read(drawingProvider.notifier).setFont(
                            'Edu_Australia'); // Set font to Edu Australia.
                        Navigator.of(context).pop();
                      },
                    ),
                    FontOption(
                      label: 'Playwrite Cuba',
                      isSelected: drawingState.selectedFont == 'Playwrite_Cuba',
                      onTap: () {
                        ref.read(drawingProvider.notifier).setFont(
                            'Playwrite_Cuba'); // Set font to Playwrite Cuba.
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class DrawingCanvas extends ConsumerStatefulWidget {
  const DrawingCanvas({super.key});

  @override
  DrawingCanvasState createState() => DrawingCanvasState();
}

class DrawingCanvasState extends ConsumerState<DrawingCanvas> {
  List<Offset> points = []; // List to store points for drawing.

  @override
  Widget build(BuildContext context) {
    final drawingState =
        ref.watch(drawingProvider); // Watching the drawing state.

    return GestureDetector(
      onPanStart: (details) {
        final line = DrawnLine(
          points: [details.localPosition],
          color: drawingState.selectedColor,
          width: drawingState.selectedThickness,
        );
        ref.read(drawingProvider.notifier).startLine(line); // Start a new line.
      },
      onPanUpdate: (details) {
        ref.read(drawingProvider.notifier).updateLine(
            details.localPosition); // Update the current line with new points.
      },
      onPanEnd: (details) {
        points = []; // Clear points on pan end.
      },
      child: CustomPaint(
        painter: DrawingPainter(drawingState,
            drawingState.selectedFont), // Custom painter for drawing.
        size: Size.infinite,
      ),
    );
  }
}
