import 'dart:convert';
import 'package:codequest/CodingPlat/GeeksForGeeks/upcomming.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class GeeksForGeeks extends StatefulWidget {
  const GeeksForGeeks({Key? key}) : super(key: key);

  @override
  State<GeeksForGeeks> createState() => _GeeksForGeeksState();
}

class _GeeksForGeeksState extends State<GeeksForGeeks> {
  Future<void> fetchContests() async {
    String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    String url = 'https://clist.by/api/v4/contest/?limit=15&host=geeksforgeeks.org&end__lt=$formattedDate&order_by=-end';
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
  List<dynamic> upcomming = [];

  @override
  void initState() {
    super.initState();
    fetchContests();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          children: [
            SizedBox(width: 25),
            Image.asset(
              'assets/CodingPlatformsIcons/img_6.png',
              height: 30,
              width: 30,
            ),
            SizedBox(width: 7),
            Text(
              'GeeksForGeeks',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            SizedBox(
              width: 22,
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.alarm,
                size: 26,
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
          return ListTile(
            leading : Image.asset('assets/CodingPlatformsIcons/img_6.png',height: 30,width: 30,),
            title: Text(contest['event']),
            subtitle: Text(contest['start']),
            onTap: () async{
              _launchContestUrl(contest['href']);
            },
          );
        },
      ),
      bottomNavigationBar: Container(
        color: Colors.black,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
          child: GNav(
            backgroundColor: Colors.black,
            color: Colors.white,
            rippleColor: Colors.grey.shade800,
            hoverColor: Colors.grey.shade700,
            haptic: true,
            tabBorderRadius: 15,
            tabActiveBorder: Border.all(color: Colors.black, width: 1),
            tabBorder: Border.all(color: Colors.grey, width: 1),
            tabShadow: [BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 8)],
            curve: Curves.easeOutExpo,
            duration: Duration(milliseconds: 900),
            activeColor: Colors.white,
            tabBackgroundColor: Colors.grey.shade800,
            gap: 8,
            padding: EdgeInsets.all(5),
            tabs: [
              GButton(
                icon: Icons.skip_previous_outlined,
                iconSize: 30,
                text: 'Past Contest',
                onPressed: () {
                  fetchContests();
                },
              ),
              GButton(
                icon: Icons.next_week_outlined,
                iconSize: 30,
                text: 'Upcoming',
                onPressed: () {
                  Navigator.push(context,MaterialPageRoute(builder: (context)=>gfgnxt()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future<void> _launchContestUrl(String url) async {
    final Uri _url=Uri.parse(url);
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }
}
