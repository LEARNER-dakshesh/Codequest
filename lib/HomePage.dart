import 'package:flutter/material.dart';
import 'package:codequest/HomePageContainer.dart';
import 'package:codequest/LstConatiner.dart';
import 'package:codequest/Roadmap.dart';
import 'package:codequest/CodingPlat/Leetcode/leetcode.dart';
import 'package:codequest/CodingPlat/HackerEarth/hackerearth.dart';
import 'package:codequest/CodingPlat/GeeksForGeeks/geeksforgeeks.dart';
import 'package:codequest/CodingPlat/CodingNinjas/codingninjas.dart';
import 'package:codequest/CodingPlat/CodeForces/codeforces.dart';
import 'package:codequest/CodingPlat/Codechef/codechef.dart';
import 'package:codequest/data/CodingPlatformsdata.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color startColor = Color(0xffFFC3A6);
  Color endColor = Colors.purple.shade200;

  String getGreeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 18) {
      return 'Good Afternoon';
    }
    else {
      return 'Good Evening';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 60, left: 20, right: 20, bottom: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    // Navigate to account settings screen
                  },
                  child: Icon(
                    Icons.account_circle,
                    color: Colors.black,
                    size: 60,
                  ),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hi Dakshesh 👋',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                    Text(
                      getGreeting() +" !!",
                      style: TextStyle(color: Colors.black54, fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: CardContainer(text: "Beginner Problems", icon: Icon(Icons.star)),
                  ),
                  SizedBox(width: 20),
                  GestureDetector(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Roadmap())),
                    child: CardContainer(text: "DSA RoadMap", icon: Icon(Icons.alt_route_rounded)),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Contests',
              style: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemCount: CodingPlatformdata.length,
                itemBuilder: (BuildContext context, index) {
                  return GestureDetector(
                    onTap: () {

                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => CodingPlat(data: CodingPlatformdata[index]),
                      //   ),
                      // );
                    },
                    child: ListContainer(
                      text: CodingPlatformdata[index].name,
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
