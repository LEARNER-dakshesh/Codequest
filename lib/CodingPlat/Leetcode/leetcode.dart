import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class Leetcode extends StatefulWidget {
  const Leetcode({Key? key}) : super(key: key);

  @override
  State<Leetcode> createState() => _LeetcodeState();
}

class _LeetcodeState extends State<Leetcode> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          children: [
            SizedBox(width: 40),
            Image.asset(
              'assets/CodingPlatformsIcons/img.png',
              height: 30,
              width: 30,
            ),
            SizedBox(width: 10),
            Text(
              'Leetcode',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            SizedBox(
              width: 61,
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.alarm,
                size: 25,
                color: Colors.white,
              ),
            ),
          ],
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      bottomNavigationBar: Container(
        color: Colors.black,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
          child: GNav(
            backgroundColor: Colors.black,
            color: Colors.white,
            rippleColor:
                Colors.grey.shade800, // tab button ripple color when pressed
            hoverColor: Colors.grey.shade700, // tab button hover color
            haptic: true, // haptic feedback
            tabBorderRadius: 15,
            tabActiveBorder:
                Border.all(color: Colors.black, width: 1), // tab button border
            tabBorder:
                Border.all(color: Colors.grey, width: 1), // tab button border
            tabShadow: [
              BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 8)
            ], // tab button shadow
            curve: Curves.easeOutExpo, // tab animation curves
            duration: Duration(milliseconds: 900),
            activeColor: Colors.white,
            tabBackgroundColor: Colors.grey.shade800,
            gap: 8,
            padding: EdgeInsets.all(5),
            tabs: [
              GButton(
                icon: Icons.skip_previous_outlined,
                onPressed: (){},
                iconSize: 30,
                text: 'Past Contest',
              ),
              GButton(
                icon: Icons.next_week_outlined,
                onPressed: (){
                  // Navigator.pushNamed(context, routeName)
                },
                iconSize: 30,
                text: 'Upcommimg ',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
