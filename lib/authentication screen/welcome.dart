import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: WelcomeScreen(),
  ));
}

class WelcomeScreen extends StatelessWidget {
  final List<String> slideTexts = [
    "Transform your body",
    "Achieve your fitness goals",
    "Stay healthy and active"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/1.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.black54, // Light background color for text
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SlideText(
                  slideTexts: slideTexts,
                ),
                SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    // Handle sign up button press
                  },
                  child: Text("Sign up with Apple"),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    // Handle sign up button press
                  },
                  child: Text("Sign up"),
                ),
                SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    // Handle login button press
                  },
                  child: Text(
                    "Already have an account? Login",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SlideText extends StatefulWidget {
  final List<String> slideTexts;

  const SlideText({required this.slideTexts});

  @override
  _SlideTextState createState() => _SlideTextState();
}

class _SlideTextState extends State<SlideText>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset(0, 0.5),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _updateIndex() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % widget.slideTexts.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: GestureDetector(
        onTap: _updateIndex,
        child: Text(
          widget.slideTexts[_currentIndex],
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
