import 'dart:convert';
import 'package:codequest/CodingPlat/Leetcode/upcomming.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

Future<void> _handleRefresh() async {
  return await Future.delayed(Duration(seconds: 2));
}

class Leetcode extends StatefulWidget {
  const Leetcode({Key? key}) : super(key: key);

  @override
  State<Leetcode> createState() => _LeetcodeState();
}

class _LeetcodeState extends State<Leetcode> {
  String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

  Future<void> fetchContests() async {
    String url =
        'https://clist.by/api/v4/contest/?limit=15&host=leetcode.com&end__lt=$formattedDate&order_by=-end';
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
    return LiquidPullToRefresh(
      onRefresh: _handleRefresh,
      color: Color(0xff171d28),
      height: 100,
      animSpeedFactor: 10,
      showChildOpacityTransition: false,
      child: Scaffold(
        backgroundColor: Colors.white,
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
                  textStyle: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(width: 52),
            ],
          ),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: contests.isEmpty
            ? Center(child: CircularProgressIndicator(color: Color(0xff171d28)))
            : ListView.builder(
          itemCount: contests.length,
          itemBuilder: (context, index) {
            final contest = contests[index];
            DateTime startDate = DateTime.parse(contest['start']);
            DateTime utcDate = DateTime.parse(contest['start']);
            DateTime istDate = utcDate.add(Duration(hours: 5, minutes: 30));
            String formattedStartDate = DateFormat('dd-MM-yyyy – hh:mm a').format(istDate);

            return Container(
              margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                leading: Image.asset(
                  'assets/CodingPlatformsIcons/img.png',
                  height: 30,
                  width: 30,
                ),
                title: Text(
                  contest['event'],
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 4),
                    Text(
                      formattedStartDate,
                      style: GoogleFonts.poppins(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                trailing: SizedBox(
                  height: 40,
                  width: 40,
                  child: Lottie.asset('assets/CodingPlatformsIcons/right.json'),
                ),
                onTap: () async {
                  _launchContestUrl(contest['href']);
                },
              ),
            );
          },
        ),
        bottomNavigationBar: Container(
          color: Color(0xff171d28),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
            child: GNav(
              backgroundColor: Color(0xff171d28),
              color: Colors.white,
              activeColor: Colors.white,
              tabBackgroundColor: Color(0xff202e3f),
              gap: 8,
              padding: EdgeInsets.all(16),
              tabs: [
                GButton(
                  icon: Icons.history,
                  onPressed: () {
                    fetchContests();
                  },
                  iconSize: 30,
                  text: 'Past Contest',
                ),
                GButton(
                  icon: Icons.upcoming,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LeetCodeContests()));
                  },
                  iconSize: 30,
                  text: 'Upcoming',
                ),
              ],
              selectedIndex: 0,
              onTabChange: (index) {
                // Handle tab changes
              },
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _launchContestUrl(String url) async {
    final Uri _url = Uri.parse(url);
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }
}
