import 'package:flutter/material.dart'; // Importing the Flutter material package for UI components.
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Importing Riverpod for state management.
import 'screens/drawing_screen.dart'; // Importing the DrawingScreen widget.

void main() async {
  // Ensuring that the Flutter widget binding is initialized.
  WidgetsFlutterBinding.ensureInitialized();

  // Running the application with a ProviderScope for Riverpod state management.
  runApp(const ProviderScope(child: MyApp()));
}

// MyApp class that extends StatelessWidget to create the main application widget.
class MyApp extends StatelessWidget {
  // Constructor for MyApp with an optional key parameter.
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Building the main MaterialApp widget.
    return MaterialApp(
      title: 'Drawing App', // Setting the title of the application.
      theme: ThemeData(
        primarySwatch: Colors.blue, // Setting the primary color swatch to blue.
      ),
      debugShowCheckedModeBanner: false, // Disabling the debug banner.
      home:
          const DrawingScreen(), // Setting the home screen to the DrawingScreen widget.
    );
  }
}
