import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'DrawerScreen/AccountStore.dart';
import 'DrawerScreen/Chat.dart';
import 'DrawerScreen/POTD.dart';

class SliderMenu extends StatefulWidget {
  const SliderMenu({Key? key}) : super(key: key);

  @override
  State<SliderMenu> createState() => _SliderMenuState();
}

class _SliderMenuState extends State<SliderMenu> {
  User? _user;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  void _loadUser() {
    setState(() {
      _user = FirebaseAuth.instance.currentUser;
    });
  }

  bool get _isGuestUser {
    return _user == null;
  }

  void _navigateToScreen(String screenName) {
    switch (screenName) {
      case 'Home':
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
        break;
      case 'POTD Challenge':
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => POTDChallengeScreen()));
        break;
      case 'Compare Profiles':
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => CompareProfilesScreen()));
        break;
      case 'Chat Room':
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ChatRoom()));
        break;
      case 'Settings':
        Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage()));
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 320,
        height: double.infinity,
        color: Color(0xFF161c28),
        child: SafeArea(
          child: Column(
            children: [
              ListTile(
                contentPadding: EdgeInsets.fromLTRB(20, 40, 0, 0),
                leading: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(CupertinoIcons.person),
                ),
                title: Text(
                  _user?.displayName ?? "Guest User",
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
                subtitle: Text(
                  "Coder",
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 24, right: 24),
                child: Divider(
                  color: Colors.white,
                  height: 40,
                ),
              ),
              GestureDetector(
                onTap: () => _navigateToScreen('Home'),
                child: Padding(
                  padding: EdgeInsets.only(left: 10.0, top: 1.0),
                  child: Row(
                    children: [
                      SizedBox(
                        height: 90,
                        width: 80,
                        child: Lottie.asset(
                          'assets/home_ani.json',
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Home',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => _navigateToScreen('POTD Challenge'),
                child: Padding(
                  padding: EdgeInsets.only(left: 10.0, top: 1.0),
                  child: Row(
                    children: [
                      SizedBox(
                        height: 90,
                        width: 70,
                        child: Lottie.asset(
                          'assets/potd.json',
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        'POTD Challenge',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => _navigateToScreen('Compare Profiles'),
                child: Padding(
                  padding: EdgeInsets.only(left: 10.0, top: 1.0),
                  child: Row(
                    children: [
                      SizedBox(
                        height: 90,
                        width: 70,
                        child: Lottie.asset(
                          'assets/comp3.json',
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Compare Profiles',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (!_isGuestUser)
                GestureDetector(
                  onTap: () => _navigateToScreen('Chat Room'),
                  child: Padding(
                    padding: EdgeInsets.only(left: 10.0, top: 1.0),
                    child: Row(
                      children: [
                        SizedBox(
                          height: 90,
                          width: 70,
                          child: Lottie.asset(
                            'assets/chat_room_ani.json',
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Discussion Room',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  _navigateToScreen('Settings');
                },
                child: Container(
                  color: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                  child: Row(
                    children: [
                      const Icon(
                        CupertinoIcons.settings,
                        color: Colors.white,
                        size: 35,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Profile Settings',
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home Screen")),
      body: Center(child: Text("Welcome to the Home Screen")),
    );
  }
}

class CompareProfilesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Compare Profiles")),
      body: Center(child: Text("Compare Profiles Screen")),
    );
  }
}
