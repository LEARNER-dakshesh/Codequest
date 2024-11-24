import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: -10.0, end: 10.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    // Check if the user is logging in for the first time
    _checkFirstTimeUser();
  }

  // Function to check if it's the user's first time
  Future<void> _checkFirstTimeUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool isFirstTime = prefs.getBool('isFirstTime') ?? true;

    // Navigate after the splash screen animation delay
    Future.delayed(Duration(seconds: 3), () {
      if (isFirstTime) {
        // Navigate to Auth page
        Navigator.pushReplacementNamed(context, 'Auth');
      } else {
        // Navigate directly to Home page
        Navigator.pushReplacementNamed(context, 'Home');
      }
    });
  }

  // Function to mark the user as no longer a first-time user
  void _onLoginSuccess() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Set `isFirstTime` to false after successful login
    await prefs.setBool('isFirstTime', false);

    // Navigate to Home page
    Navigator.pushReplacementNamed(context, 'Home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.black, Colors.white, Colors.black38],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(height: 50),
            AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0.0, _animation.value),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(150.0),
                    child: Image.asset(
                      'assets/back3.jpg',
                      height: 300,
                      width: 300,
                    ),
                  ),
                );
              },
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(60),
                  topRight: Radius.circular(60),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Discover The Best Coding Booster Partner🌋",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        )),
                  ),
                  SizedBox(height: 15),
                  Text(
                    "Deep Dive into the heart of Problem Solving",
                    style: GoogleFonts.poppins(
                      textStyle:
                      TextStyle(fontSize: 14, color: Colors.grey.shade600),
                    ),
                  ),
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'Auth');
                      },
                      child: Text(
                        "Explore Now 🚀",
                        style: GoogleFonts.poppins(
                            textStyle:
                            TextStyle(color: Colors.black, fontSize: 16)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
