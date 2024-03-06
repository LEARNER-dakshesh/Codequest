import 'package:flutter/material.dart';

class ContestDetailsPage extends StatelessWidget {
  final dynamic contest;

  const ContestDetailsPage({Key? key, required this.contest}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contest Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Event Name: ${contest['event']}',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              'Start Date: ${contest['start']}',
              style: TextStyle(fontSize: 20),
            ),
            // Add more details as needed
          ],
        ),
      ),
    );
  }
}
