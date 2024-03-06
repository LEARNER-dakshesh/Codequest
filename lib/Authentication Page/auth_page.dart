import 'package:codequest/Authentication%20Page/otp_screen.dart';
import 'package:codequest/HomePage/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:email_otp/email_otp.dart';
import '../Animation/FadeAnimation.dart'; // Assuming you have the FadeAnimation widget
import 'package:http/http.dart' as http;
import 'package:email_auth/email_auth.dart';
import 'package:google_fonts/google_fonts.dart';

class Auth extends StatefulWidget {
  const Auth({Key? key}) : super(key: key);

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  Color myColor = Color(0xffFFC3A6);
  EmailOTP myauth = EmailOTP();
  final TextEditingController email = TextEditingController();
  final TextEditingController _otpController1 = TextEditingController();
  final TextEditingController _otpController2 = TextEditingController();
  final TextEditingController _otpController3 = TextEditingController();
  final TextEditingController _otpController4 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 30),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            // colors: [myColor, Colors.purple.shade200],
            colors: [Colors.black,Colors.white,Colors.black38]
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 50),
            FadeInUp(
              duration: Duration(milliseconds: 1000),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Login",
                      style:GoogleFonts.poppins(textStyle:TextStyle(color: Colors.black, fontSize: 40),
                    )),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Welcome Back ",
                      style:GoogleFonts.poppins(textStyle:TextStyle(color: Colors.black, fontSize: 22),
                    )),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60),
                        bottomLeft: Radius.circular(60),
                        bottomRight: Radius.circular(60),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: FadeInUp(
                        duration: Duration(milliseconds: 1200),
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: 30),
                            Text(
                              "We need to verify you before getting started !",
                              style: GoogleFonts.poppins(textStyle:TextStyle(
                                fontSize: 16,
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                              )),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            FadeInUp(
                              duration: Duration(milliseconds: 1400),
                              child: Container(
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(color: Colors.grey),
                                        ),
                                      ),
                                      child: TextField(
                                        controller: email,
                                        decoration: InputDecoration(
                                          hintText: "Enter Email Address",
                                          labelText: "Email",
                                          suffixIcon: IconButton(
                                            onPressed: () async {
                                              myauth.setConfig(
                                                appEmail: "codequestcn@gmail.com",
                                                appName: "Email Otp",
                                                userEmail: email.text,
                                                otpLength: 4,
                                                otpType: OTPType.digitsOnly,
                                              );
                                              if (await myauth.sendOTP() == true) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(content: Text("OTP has been sent")),
                                                );
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(content: Text("Oops, OTP send Failed")),
                                                );
                                              }
                                            },
                                            icon: Icon(Icons.send), // Use the send icon or replace it with the desired icon
                                          ),
                                          hintStyle: TextStyle(color: Colors.grey),
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Expanded(
                                          child: Container(
                                            margin: EdgeInsets.symmetric(horizontal: 5),
                                            decoration: BoxDecoration(
                                              border: Border(
                                                bottom: BorderSide(color: Colors.grey),
                                              ),
                                            ),
                                            child: TextFormField(
                                              controller: _otpController1,
                                              keyboardType: TextInputType.number,
                                              textAlign: TextAlign.center,
                                              maxLength: 1,
                                              onChanged: (value) {
                                                if (value.length == 1) {
                                                  FocusScope.of(context).nextFocus();
                                                }
                                                if (value.isEmpty) {
                                                  FocusScope.of(context).previousFocus();
                                                }
                                              },
                                              decoration: InputDecoration(
                                                counterText: "", // Hide character counter
                                                border: InputBorder.none,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            margin: EdgeInsets.symmetric(horizontal: 5),
                                            decoration: BoxDecoration(
                                              border: Border(
                                                bottom: BorderSide(color: Colors.grey),
                                              ),
                                            ),
                                            child: TextFormField(
                                              controller: _otpController2,
                                              keyboardType: TextInputType.number,
                                              textAlign: TextAlign.center,
                                              maxLength: 1,
                                              onChanged: (value) {
                                                if (value.length == 1) {
                                                  FocusScope.of(context).nextFocus();
                                                }
                                                if (value.isEmpty) {
                                                  FocusScope.of(context).previousFocus();
                                                }
                                              },
                                              decoration: InputDecoration(
                                                counterText: "", // Hide character counter
                                                border: InputBorder.none,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            margin: EdgeInsets.symmetric(horizontal: 5),
                                            decoration: BoxDecoration(
                                              border: Border(
                                                bottom: BorderSide(color: Colors.grey),
                                              ),
                                            ),
                                            child: TextFormField(
                                              controller: _otpController3,
                                              keyboardType: TextInputType.number,
                                              textAlign: TextAlign.center,
                                              maxLength: 1,
                                              onChanged: (value) {
                                                if (value.length == 1) {
                                                  FocusScope.of(context).nextFocus();
                                                }
                                                if (value.isEmpty) {
                                                  FocusScope.of(context).previousFocus();
                                                }
                                              },
                                              decoration: InputDecoration(
                                                counterText: "", // Hide character counter
                                                border: InputBorder.none,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            margin: EdgeInsets.symmetric(horizontal: 5),
                                            decoration: BoxDecoration(
                                              border: Border(
                                                bottom: BorderSide(color: Colors.grey),
                                              ),
                                            ),
                                            child: TextFormField(
                                              controller: _otpController4,
                                              keyboardType: TextInputType.number,
                                              textAlign: TextAlign.center,
                                              maxLength: 1,
                                              onChanged: (value) {
                                                if (value.length == 1) {
                                                  FocusScope.of(context).nextFocus();
                                                }
                                                if (value.isEmpty) {
                                                  FocusScope.of(context).previousFocus();
                                                }
                                              },
                                              decoration: InputDecoration(
                                                counterText: "", // Hide character counter
                                                border: InputBorder.none,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            FadeInUp(
                              duration: Duration(milliseconds: 1600),
                              child: Container(
                                height: 50,
                                margin: EdgeInsets.symmetric(),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.blue,
                                ),
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (myauth.verifyOTP(otp: _otpController1.text +
                                        _otpController2.text +
                                        _otpController3.text +
                                        _otpController4.text) == true) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text("OTP is verified")),
                                      );
                                      // Navigate to the next screen or perform the desired action
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => HomePage(),
                                        ),
                                      );
                                    } else {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text("Invalid OTP"),
                                        ),
                                      );
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(

                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ), backgroundColor: Colors.black,
                                    fixedSize: Size(300, 30)
                                  ),
                                  child: Text(
                                    "Verify OTP",
                                    style:GoogleFonts.poppins(textStyle:TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    )),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            FadeInUp(
                              duration: Duration(milliseconds: 1800),
                              child: Text(
                                "Continue with Social Media",
                                style: GoogleFonts.poppins(textStyle:TextStyle(color: Colors.grey),
                              )),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            FadeInUp(
                              duration: Duration(milliseconds: 2000),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      height: 50,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                       color:Colors.black
                                      ),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          // Add your button click logic here
                                        },
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(50),
                                          ), backgroundColor: Colors.black
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              'assets/google_logo.png',
                                              height: 20,
                                            ),
                                            SizedBox(width: 10),
                                            Text(
                                              "Google",
                                              style:GoogleFonts.poppins(textStyle: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              )),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 30,
                                  ),
                                  Expanded(
                                    child: Container(
                                      height: 50,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          colors: [myColor, Colors.purple],
                                        ),
                                        color: Colors.black,
                                      ),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          // Add your button click logic here
                                        },
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(50),
                                          ), backgroundColor: Colors.black
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              'assets/github_lo.png',
                                              height: 28,
                                            ),
                                            SizedBox(width: 5),
                                            Text(
                                              "Github",
                                              style: GoogleFonts.poppins(textStyle:TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              )),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 80),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
