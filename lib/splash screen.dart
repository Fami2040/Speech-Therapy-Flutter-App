import 'package:flutter/material.dart';
import 'package:speech_therapy/dashboard.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late Animation<double> _logoAnimation;
  late AnimationController _textController;
  late Animation<double> _textAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize the logo animation controller and animation
    _logoController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _logoAnimation = CurvedAnimation(
      parent: _logoController,
      curve: Curves.easeIn,
    );
    _logoController.forward();

    // Initialize the text animation controller and animation
    _textController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _textAnimation = CurvedAnimation(
      parent: _textController,
      curve: Curves.easeIn,
    );

    // Delay the text animation to start after the logo animation
    Future.delayed(Duration(seconds: 2), () {
      _textController.forward();
    });

    _navigateToHome();
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    super.dispose();
  }

  _navigateToHome() async {
    await Future.delayed(
        Duration(seconds: 4), () {}); // Adjust the duration as needed
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) =>
              Dashboard()), // Replace with your home screen or next screen
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo, // Set your desired background color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FadeTransition(
              opacity: _logoAnimation,
              child: Image.asset('assets/logo.png',
                  width: 200, height: 200), // Adjust size as needed
            ),
            SizedBox(height: 20), // Space between logo and text
            FadeTransition(
              opacity: _textAnimation,
              child: Center(
                child: Text(
                  'እንኳን ደህና መጡ',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
