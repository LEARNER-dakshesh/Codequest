import 'dart:convert';
import 'package:timezone/timezone.dart' as tz;
import 'package:codequest/CodingPlat/Leetcode/upcomming.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class Leetcode extends StatefulWidget {
  const Leetcode({Key? key}) : super(key: key);

  @override
  State<Leetcode> createState() => _LeetcodeState();
}

class _LeetcodeState extends State<Leetcode> {

  String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  Future<void> fetchContests() async {
     String url = 'https://clist.by/api/v4/contest/?limit=5&host=leetcode.com&end__lt=$formattedDate&order_by=-end';
    try {
      final response = await http.get(Uri.parse(url), headers: {
        "Authorization": "ApiKey Dakshesh_Gupta:36f42779bf83119f213ea813c6885d79254b5964"
      });

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          contests = data['objects'];
        });
      } else {
        print('Failed to load contests');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  List<dynamic> contests = [];

  @override
  void initState() {
    super.initState();
    fetchContests();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff171d28),
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
              style: GoogleFonts.poppins(
                textStyle: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
            SizedBox(
              width: 52,
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
        body: ListView.builder(
          itemCount: contests.length,
          itemBuilder: (context, index) {
            final contest = contests[index];
            String eventName = contest['event'];
            String startDateTime = contest['start'];
            String formattedDateTime = DateFormat('dd-MM-yyyy HH:mm').format(DateTime.parse(startDateTime).toLocal());

            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ContestDetailsPage(contest)),
                );
              },
              child: ListTile(
                title: Text(eventName),
                subtitle: Text(formattedDateTime),
              ),
            );
          },
        ),
      bottomNavigationBar: Container(
        color: Color(0xff171d28),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
          child: GNav(
            backgroundColor: Color(0xff171d28),
            color: Colors.white,
            rippleColor: Color(0xff202e3f),
            hoverColor: Color(0xff202e3f),
            haptic: true,
            tabBorderRadius: 15,
            tabActiveBorder: Border.all(color: Color(0xff202e3f), width: 1),
            tabBorder: Border.all(color: Colors.grey, width: 1),
            tabShadow: [BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 8)],
            curve: Curves.easeOutExpo,
            duration: Duration(milliseconds: 900),
            activeColor: Colors.white,
            tabBackgroundColor: Color(0xff202e3f),
            gap: 8,
            padding: EdgeInsets.all(5),
            tabs: [
              GButton(
                icon: Icons.skip_previous_outlined,
                onPressed: () {
                  fetchContests();
                  // Navigator.push(context, MaterialPageRoute(builder: (context)=>Lcpst()));
                },
                iconSize: 30,
                text: 'Past Contest',
              ),
              GButton(
                icon: Icons.next_week_outlined,
                onPressed: () {
               Navigator.push(context, MaterialPageRoute(builder: (context)=>lcnxt()));
                  // Navigator.push(context, MaterialPageRoute(builder: (context)=>lcnxt()));
                },
                iconSize: 30,
                text: 'Upcoming',
              ),
            ],
          ),
        ),
      ),
    );
  }

}
