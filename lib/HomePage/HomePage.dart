import 'package:flutter/material.dart';
import '../Authentication Page/auth_page.dart';
import '../BeginnerProblem.dart';
import '../Drawer.dart';
import 'HomePageContainer.dart';
import 'LstConatiner.dart';
import 'package:codequest/Roadmap.dart';
import 'package:codequest/CodingPlat/LeetCode/leetcode.dart';
import 'package:codequest/CodingPlat/HackerEarth/hackerearth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:codequest/CodingPlat/GeeksForGeeks/geeksforgeeks.dart';
import 'package:codequest/CodingPlat/CodingNinjas/codingninjas.dart';
import 'package:codequest/CodingPlat/CodeForces/codeforces.dart';
import 'package:codequest/CodingPlat/Codechef/codechef.dart';
import 'package:codequest/data/CodingPlatformsdata.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    _loadUser();
    checkVerification();
  }

  Future<void> checkVerification() async {
    final prefs = await SharedPreferences.getInstance();
    bool isOTPPending = prefs.getBool('isOTPPending') ?? false;

    if (isOTPPending) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Auth(),
        ),
      );
    }
  }
  User? _user;

  // @override
  // void initState() {
  //   super.initState();
  //   _loadUser();
  // }

  // Fetch the current user's details
  void _loadUser() {
    setState(() {
      _user = FirebaseAuth.instance.currentUser;
    });
  }

  Map<String, Widget> platformScreens = {
    'LeetCode': Leetcode(),
    'CodeChef': Codechef(),
    'CodeForces': Codeforces(),
    'GeeksForGeeks': GeeksForGeeks(),
    'CodingNinjas': CodingNinjas(),
    'HackerEarth': Hackerearth()
  };

  String getGreeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 18) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff171d28),
      appBar: AppBar(
        backgroundColor: Color(0xff171d28),
        title: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hi ${_user?.displayName?.split(' ').first ?? "Guest"} 👋',
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                  Text(
                    getGreeting() + " !!",
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        color: Colors.white70,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton(
              icon: const Icon(Icons.exit_to_app, color: Colors.white, size: 28),
              onPressed: () {
                _showSignOutDialog(context);
              },
            ),
          ),
        ],
        iconTheme: IconThemeData(color: Colors.white),
        ),
      drawer: Drawer(
        backgroundColor: Color(0xFF161c28),
        child: SliderMenu(),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              child: Row(
                children: [
                  Expanded(child: SizedBox()),
                  GestureDetector(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => BeginnerProblem())),
                    child: CardContainer(text: "Beginner Problems", icon: Icon(Icons.star)),
                  ),
                  Expanded(child: SizedBox()),
                  GestureDetector(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Roadmap())),
                    child: CardContainer(text: "DSA RoadMap", icon: Icon(Icons.alt_route_rounded),backgroundColor: Colors.redAccent),
                  ),
                  Expanded(child: SizedBox()),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Contests',
              style: GoogleFonts.poppins(textStyle: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemCount: CodingPlatformdata.length,
                itemBuilder: (BuildContext context, index) {
                  return GestureDetector(
                    onTap: () {
                      String platformName = CodingPlatformdata[index].name;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            if (platformScreens.containsKey(platformName)) {
                              return platformScreens[platformName]!;
                            } else {
                              return Scaffold(
                                body: Center(
                                  child: Text('Screen for $platformName not defined.'),
                                ),
                              );
                            }
                          },
                        ),
                      );
                    },
                    child: ListContainer(
                      text: CodingPlatformdata[index].name,
                      textStyle: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      imagepath: CodingPlatformdata[index].imagePath,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void _showSignOutDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20), // Rounded corners
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFF161c28), // Matches your app background
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Icon at the top
              const Icon(
                Icons.logout_rounded,
                size: 50,
                color: Colors.redAccent,
              ),
              const SizedBox(height: 20),
              // Title
              Text(
                'Sign Out?',
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              // Description
              Text(
                'Are you sure you want to sign out?',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              // Buttons Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2c3a4d),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Cancel',
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      Navigator.of(context).pop();
                      await FirebaseAuth.instance.signOut();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const Auth()),
                      ); // Navigate to Auth screen
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Sign Out',
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
