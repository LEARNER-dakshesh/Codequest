import 'dart:convert';
import 'package:codequest/CodingPlat/CodingNinjas/codingninjas.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class ninjasnxt extends StatefulWidget {
  const ninjasnxt({Key? key}) : super(key: key);

  @override
  State<ninjasnxt> createState() => _ninjasnxtState();
}

class _ninjasnxtState extends State<ninjasnxt> {

  Future<void>ninjasnxt() async{

    String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    print(formattedDate);
    String url = 'https://clist.by/api/v4/contest/?limit=15&host=codingninjas.com/codestudio&start__gt=$formattedDate&order_by=-end';
    try {
      final response = await http.get(Uri.parse(url), headers: {
        "Authorization": "ApiKey Dakshesh_Gupta:36f42779bf83119f213ea813c6885d79254b5964"
      });

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          upcomming = data['objects'];
        });
      } else {
        print('Failed to load contests');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  List<dynamic>upcomming=[];

  @override
  void initState(){
    super.initState();
    ninjasnxt();
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
              'assets/CodingPlatformsIcons/img_4.png',
              height: 30,
              width: 30,
            ),
            SizedBox(width: 10),
            Text(
              'Coding Ninjas',
              style: TextStyle(fontSize: 20,color: Colors.white),
            ),
            SizedBox(
              width: 35,
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.alarm,
                size: 27,
                color: Colors.white,
              ),
            ),
          ],
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: ListView.builder(
        itemCount: upcomming.length,
        itemBuilder: (context, index) {
          final contest = upcomming[index];
          return ListTile(
            leading : Image.asset('assets/CodingPlatformsIcons/img_4.png',height: 30,width: 30,),
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
            rippleColor: Colors.grey.shade800, // tab button ripple color when pressed
            hoverColor: Colors.grey.shade700, // tab button hover color
            haptic: true, // haptic feedback
            tabBorderRadius: 15,
            tabActiveBorder: Border.all(color: Colors.black, width: 1), // tab button border
            tabBorder: Border.all(color: Colors.grey, width: 1), // tab button border
            tabShadow: [BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 8)], // tab button shadow
            curve: Curves.easeOutExpo, // tab animation curves
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
                onPressed: (){
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>CodingNinjas()));
                },
              ),
              GButton(
                icon: Icons.next_week_outlined,
                iconSize: 30,
                text: 'Upcommimg ',
                onPressed: (){
                 ninjasnxt();
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
