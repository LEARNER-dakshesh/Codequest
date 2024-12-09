import 'package:flutter/material.dart';

class CardContainer extends StatelessWidget {
  const CardContainer({required this.text, required this.icon,this.backgroundColor = const Color(0xff202e3f), Key? key})
      : super(key: key);

  final Icon icon;
  final String text;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double cardWidth = screenWidth * 0.4;
    double cardHeight = cardWidth * 1;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        width: cardWidth,
        height: cardHeight, // Set height for consistent size
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          // color: const Color(0xff202e3f),
          color: backgroundColor,
        ),
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon.icon,
              color: Colors.white,
              size: 40,
            ),
            const SizedBox(height: 20),
            Text(
              text,
              style: const TextStyle(color: Colors.white, fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
