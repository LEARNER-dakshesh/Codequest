import 'package:flutter/material.dart';
import 'package:codequest/HomePageContainer.dart';
import 'package:codequest/LstConatiner.dart';
import 'package:codequest/Roadmap.dart';
import 'package:codequest/data/CodingPlatformsdata.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF161c28),
      body: Padding(
        padding: const EdgeInsets.only(top: 30,left: 30,right: 40,bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Hi 👋 User Name', style: TextStyle(color: Color(0xFFb4b8c1),fontSize: 25),),
            Text('Welcome Back', style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 8),
              child: Row(
                children: [
                  GestureDetector(
                      onTap: (){},
                      child: HomePageConatainer(text: "Beginer Problems",icon: Icon(Icons.star),)),
                  Expanded(child: SizedBox()),
                  GestureDetector(
                      onTap: ()=>Navigator.push(context, MaterialPageRoute(builder:(context)=>Roadmap())),
                      child: HomePageConatainer(text: "DSA RoadMap",icon: Icon(Icons.alt_route_rounded),))],
              ),
            ),
            Text('Contests', style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),),
            Container(
              height: 500,
              width: double.maxFinite,
              child: ListView.builder(

                   itemCount: CodingPlatformdata.length,
                  itemBuilder: (BuildContext context,index){
                return ListContainer(text: CodingPlatformdata[index].name,imagepath: CodingPlatformdata[index].imagePath,);
              }),
            )
          ],
        ),
      ),
    );
  }
}

