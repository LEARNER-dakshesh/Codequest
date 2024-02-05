import 'package:flutter/material.dart';
import 'HomePageContainer.dart';
import 'LstConatiner.dart';
import 'package:codequest/Roadmap.dart';
import 'package:codequest/CodingPlat/LeetCode/leetcode.dart';
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
      body: Padding(
        padding: const EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 0),
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
                    color: Colors.white,
                    size: 50,
                  ),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hi Dakshesh 👋',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    Text(
                      getGreeting() +" !!",
                      style: TextStyle(color: Colors.white70, fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            SingleChildScrollView(

              child: Row(
                children: [
                  Expanded(
                      child: SizedBox()) ,
                  GestureDetector(
                    onTap: () {},
                    child: CardContainer(text: "Beginner Problems", icon: Icon(Icons.star)),
                  ),
                Expanded(
                    child: SizedBox()) ,
                  GestureDetector(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Roadmap())),
                    child: CardContainer(text: "DSA RoadMap", icon: Icon(Icons.alt_route_rounded)),
                  ),
                  Expanded(
                      child: SizedBox()) ,
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Contests',
              style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
            ),
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
