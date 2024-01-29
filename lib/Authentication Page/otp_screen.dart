import 'package:flutter/material.dart';

class Otp_page extends StatefulWidget {
  const Otp_page({Key? key}) : super(key: key);

  @override
  State<Otp_page> createState() => _Otp_pageState();
}

class _Otp_pageState extends State<Otp_page> {
  Color myColor = Color(0xffFFC3A6);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 30),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                colors: [myColor, Colors.purple.shade200],
              ),
            ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text("Verification", style: TextStyle(color: Colors.white, fontSize: 40),),
              ),
              SizedBox(height: 20,),
              Expanded(
                child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60),
                        bottomLeft: Radius.circular(60),
                        bottomRight: Radius.circular(60),
                      ),
                      )
                      )
              ),
              ),
            ],
          ),

        )

    );
  }
}
