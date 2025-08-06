import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart'; // Import the webview_flutter package

void main() {
  // This is the entry point of your Flutter application.
  // It runs the MyApp widget.
  runApp(const MyApp());
}

// MyApp is a StatelessWidget, meaning its properties don't change over time.
// It sets up the basic Material Design structure for your app.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Title for the app, used by the OS for task switcher, etc.
      title: 'Flutter WebView App',
      // Define the app's theme.
      theme: ThemeData(
        // Set the primary color for the app bar and other widgets.
        primarySwatch: Colors.blue,
      ),
      // The home property now points to our new SplashScreen.
      // The SplashScreen will handle the initial display and then navigate to the WebViewScreen.
      home: const SplashScreen(),
    );
  }
}

// SplashScreen is a StatefulWidget to manage its own state (e.g., timer for navigation).
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Use Future.delayed to simulate a loading time for your splash screen.
    // After 3 seconds, it will navigate to the WebViewScreen.
    Future.delayed(const Duration(seconds: 3), () {
      // Navigate to the WebViewScreen and replace the current route,
      // so the user can't go back to the splash screen using the back button.
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const WebViewScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The body of the splash screen. You can customize this heavily!
      body: Container(
        // Changed background color to #f8f7f3
        color: const Color(0xFFF8F7F3),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Added Image.asset for your icon.png
              // Make sure to add 'assets/icon.png' to your pubspec.yaml under 'assets:'
              Image.asset(
                'assets/icon.png', // Path to your custom icon
                width: 150, // Adjust size as needed
                height: 150, // Adjust size as needed
              ),
              const SizedBox(height: 20),
              // Changed text to 'InkVerse'
              const Text(
                'Welcome to the World of Stories',
                textAlign: TextAlign.center, // Center the text
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 28, // Reduced font size
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue), // Changed progress indicator color
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// WebViewScreen is a StatefulWidget because its state (the WebView content,
// loading progress, etc.) can change over time.
class WebViewScreen extends StatefulWidget {
  const WebViewScreen({super.key});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

// The State class for WebViewScreen. This is where the mutable state lives.
class _WebViewScreenState extends State<WebViewScreen> {
  // Declare a late final WebViewController.
  // 'late' means it will be initialized before use, and 'final' means it won't
  // be reassigned after initialization.
  late final WebViewController _controller;
  // State variable to track the loading progress of the WebView.
  int _loadingProgress = 0;

  @override
  void initState() {
    super.initState();
    // Initialize the WebViewController in the initState method.
    // This ensures the controller is ready when the widget is built.
    _controller = WebViewController()
    // Enable JavaScript execution within the WebView.
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
    // Set a NavigationDelegate to control navigation and handle events.
      ..setNavigationDelegate(
        NavigationDelegate(
          // Callback when the WebView's loading progress changes.
          onProgress: (int progress) {
            // Update the loading progress state to trigger a UI rebuild.
            setState(() {
              _loadingProgress = progress;
            });
            debugPrint('WebView is loading (progress: $progress%)');
          },
          // Callback when a new page starts loading.
          onPageStarted: (String url) {
            debugPrint('Page started loading: $url');
            // Reset progress when a new page starts.
            setState(() {
              _loadingProgress = 0;
            });
          },
          // Callback when a page finishes loading.
          onPageFinished: (String url) {
            debugPrint('Page finished loading: $url');
            // Ensure progress is 100% when finished.
            setState(() {
              _loadingProgress = 100;
            });
          },
          // Callback when a web resource error occurs (e.g., page not found).
          onWebResourceError: (WebResourceError error) {
            debugPrint('''
              Page resource error:
                code: ${error.errorCode}
                description: ${error.description}
                errorType: ${error.errorType}
                isForMainFrame: ${error.isForMainFrame}
            ''');
            // You might want to show an error message to the user here.
            // For example, display a simple error message on the screen.
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error loading page: ${error.description}')),
            );
          },
          // Callback to decide whether to allow or prevent a navigation request.
          // This is useful for intercepting specific URLs.
          onNavigationRequest: (NavigationRequest request) {
            debugPrint('allowing navigation to ${request.url}');
            return NavigationDecision.navigate;
          },
        ),
      )
    // Load the initial URL into the WebView.
    // Replace 'https://www.example.com' with the URL of the webpage you want to display.
      ..loadRequest(Uri.parse('https://sumit7739.github.io/InkVerse')); // Using your provided URL
  }

  @override
  Widget build(BuildContext context) {
    return PopScope( // <--- NEW: Wrap the Scaffold with PopScope
      canPop: false, // <--- NEW: Initially prevent popping
      onPopInvoked: (bool didPop) async { // <--- NEW: Callback when a pop is invoked
        if (didPop) {
          // If the system already handled the pop (e.g., due to an earlier canPop: true),
          // we don't need to do anything.
          return;
        }

        // Check if the WebView can go back in its history.
        if (await _controller.canGoBack()) {
          // If it can, tell the WebView to go back.
          await _controller.goBack();
        } else {
          // If the WebView cannot go back, then allow the app to be popped
          // (i.e., close the app if it's the last route).
          if (context.mounted) { // Ensure the widget is still mounted before navigating
            Navigator.of(context).pop();
          }
        }
      },
      child: Scaffold(
        // Removed the AppBar as requested.
        // The body of the Scaffold contains the WebViewWidget,
        // which displays the web content using the controller.
        body: Stack( // Use a Stack to layer the WebView and the progress indicator.
          children: [
            WebViewWidget(controller: _controller),
            // Show a LinearProgressIndicator if the page is still loading.
            if (_loadingProgress < 100)
              LinearProgressIndicator(
                value: _loadingProgress / 100.0, // Normalize progress to 0.0-1.0
                backgroundColor: Colors.blue.shade100,
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
          ],
        ),
      ),
    );
  }
}
