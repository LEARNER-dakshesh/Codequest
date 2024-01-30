import 'package:flutter/material.dart';

class HomePageConatainer extends StatelessWidget {
  const HomePageConatainer({required this.text,required this.icon,super.key});
  final Icon icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color(0xFF202e3f),
      ),
      height: 150,
      width: 150,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon.icon,
              color: Colors.white, // Set the color
              size: 40, // Set the size
            ),
            SizedBox(height: 10,),
            Text(text,style: TextStyle(color: Colors.white,fontSize: 20,),textAlign: TextAlign.center,),

          ],
        ),
      ),
    );
  }
}
