import 'package:flutter/material.dart';

class CardContainer extends StatelessWidget {
  const CardContainer({required this.text, required this.icon, Key? key}) : super(key: key);

  final Icon icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    Color startColor = Color(0xffFFC3A6);
    Color endColor = Colors.purple.shade200;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        width: 250,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            colors: [startColor, endColor],
          ),
        ),
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon.icon,
              color: Colors.black87,
              size: 40,
            ),
            SizedBox(height: 30),
            Text(
              text,
              style: TextStyle(color: Colors.black, fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
