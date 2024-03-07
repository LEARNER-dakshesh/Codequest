import 'dart:convert';
import 'package:codequest/CodingPlat/Codechef/codechef.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class Codechefnxt extends StatefulWidget {
  const Codechefnxt({Key? key}) : super(key: key);

  @override
  State<Codechefnxt> createState() => _CodechefnxtState();
}

class _CodechefnxtState extends State<Codechefnxt> {
  Future<void> fetchContests() async {
    String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    String url = 'https://clist.by/api/v4/contest/?limit=15&host=codechef.com&start__gt=$formattedDate&order_by=start';
    try {
      final response = await http.get(Uri.parse(url), headers: {
        "Authorization": "ApiKey Dakshesh_Gupta:36f42779bf83119f213ea813c6885d79254b5964"
      });

      if (response.statusCode == 200) {
        print('done');
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
  List<dynamic> upcomming =[];

  @override
  void initState(){
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
            SizedBox(width: 40),
            Image.asset(
              'assets/CodingPlatformsIcons/img_1.png',
              height: 30,
              width: 30,
            ),
            SizedBox(width: 10),
            Text(
              'Codechef',
              style: TextStyle(fontSize: 20,color: Colors.white),
            ),
            SizedBox(
              width: 58,
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
        itemCount: upcomming.length,
          itemBuilder: (context,index){
          final contest=upcomming[index];
          print(contest['event']);
          String formattedDate1 = DateFormat('dd-MM-yyyy HH:mm').format(DateTime.parse(contest['start']));
          return ListTile(
            leading : Image.asset('assets/CodingPlatformsIcons/img_1.png',height: 30,width: 30,),
            title: Text(contest['event']),
            subtitle: Text(formattedDate1),
            onTap: () async{
              _launchContestUrl(contest['href']);
            },
          );
      }),
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
            curve: Curves.easeOutExpo,
            duration: Duration(milliseconds: 900),// tab animation curves
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
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Codechef()));
                },
              ),
              GButton(
                icon: Icons.next_week_outlined,
                iconSize: 30,
                text: 'Upcommimg ',
                onPressed: (){
                  fetchContests();
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
