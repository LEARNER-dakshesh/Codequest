import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart' as parser;
import 'package:url_launcher/url_launcher.dart';
import 'package:html/parser.dart';  // This is the correct import
import 'dart:convert';


class SliderMenu extends StatefulWidget {
  const SliderMenu({Key? key}) : super(key: key);

  @override
  State<SliderMenu> createState() => _SliderMenuState();
}

class _SliderMenuState extends State<SliderMenu> {
  User? _user; // To store the current user

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  // Fetch the current user's details
  void _loadUser() {
    setState(() {
      _user = FirebaseAuth.instance.currentUser;
    });
  }

  // Method to navigate to the respective screen
  void _navigateToScreen(String screenName) {
    switch (screenName) {
      case 'Home':
        Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
        break;
      case 'POTD Challenge':
        Navigator.push(context, MaterialPageRoute(builder: (context) => POTDChallengeScreen()));
        break;
      case 'Compare Profiles':
        Navigator.push(context, MaterialPageRoute(builder: (context) => CompareProfilesScreen()));
        break;
      case 'Chat Room':
        Navigator.push(context, MaterialPageRoute(builder: (context) => ChatRoomScreen()));
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 320,
        height: double.infinity,
        color: Color(0xFF161c28),
        child: SafeArea(
          child: Column(
            children: [
              ListTile(
                contentPadding: EdgeInsets.fromLTRB(20,40,0,0),
                leading: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(CupertinoIcons.person),
                ),
                title: Text(
                  _user?.displayName ?? "Guest User",
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
                subtitle: Text(
                  "Coder",
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 24, right: 24),
                child: Divider(
                  color: Colors.white,
                  height: 40,
                ),
              ),
              // Home ListTile
              GestureDetector(
                onTap: () => _navigateToScreen('Home'),
                child: Padding(
                  padding:EdgeInsets.only(left: 10.0,top: 1.0),
                  child: Row(
                    children: [
                      SizedBox(
                        height: 90,
                        width: 80,
                        child: Lottie.asset(
                          'assets/home_ani.json',
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Home',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // POTD Challenge ListTile
              GestureDetector(
                onTap: () => _navigateToScreen('POTD Challenge'),
                child: Padding(
                  padding:EdgeInsets.only(left: 10.0,top: 1.0),
                  child: Row(
                    children: [
                      SizedBox(
                        height: 90,
                        width: 70,
                        child: Lottie.asset(
                          'assets/potd.json',
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        'POTD Challenge',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Compare Profiles ListTile
              GestureDetector(
                onTap: () => _navigateToScreen('Compare Profiles'),
                child: Padding(
                  padding:EdgeInsets.only(left: 10.0,top: 1.0),
                  child: Row(
                    children: [
                      SizedBox(
                        height: 90,
                        width: 70,
                        child: Lottie.asset(
                          'assets/comp3.json',
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Compare Profiles',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Chat Room ListTile
              GestureDetector(
                onTap: () => _navigateToScreen('Chat Room'),
                child: Padding(
                  padding:EdgeInsets.only(left: 10.0,top: 1.0),
                  child: Row(
                    children: [
                      SizedBox(
                        height: 90,
                        width: 70,
                        child: Lottie.asset(
                          'assets/chat_room_ani.json',
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Chat Room',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // You can add more ListTiles here with their respective navigation logic
            ],
          ),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home Screen")),
      body: Center(child: Text("Welcome to the Home Screen")),
    );
  }
}
class POTDChallengeScreen extends StatefulWidget {
  @override
  _POTDChallengeScreenState createState() => _POTDChallengeScreenState();
}

class _POTDChallengeScreenState extends State<POTDChallengeScreen> {
  // GeeksForGeeks POTD data
  String gfgProblemName = '';
  String gfgDifficulty = '';
  String gfgAccuracy = '';
  String gfgProblemUrl = '';

  // LeetCode POTD data
  String leetcodeProblemName = '';
  String leetcodeDifficulty = '';
  String leetcodeProblemUrl = '';
  String leetcodeAcceptanceRate = '';

  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchAllProblems();
  }

  Future<void> _fetchAllProblems() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    try {
      await Future.wait([
        _fetchGeeksForGeeksPOTD(),
        _fetchLeetCodePOTD(),
      ]);
    } catch (e) {
      setState(() {
        errorMessage = 'Failed to load one or more problems. Please try again later.';
      });
      print('Debug - Error: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _fetchGeeksForGeeksPOTD() async {
    try {
      final response = await http.get(
        Uri.parse('https://practiceapi.geeksforgeeks.org/api/v1/problems-of-day/problem/today/'),
        headers: {
          'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36',
          'Accept': 'application/json',
        },
      ).timeout(Duration(seconds: 15));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        setState(() {
          gfgProblemName = jsonData['problem_name'] ?? 'No Title Available';
          gfgDifficulty = jsonData['difficulty'] ?? 'Unknown';
          gfgProblemUrl = jsonData['problem_url'] ?? '';
          gfgAccuracy = '${(jsonData['accuracy'] ?? 0).toStringAsFixed(2)}%';
        });
      } else {
        throw Exception('Failed to load GFG POTD (Status: ${response.statusCode})');
      }
    } catch (e) {
      print('Debug - GFG Error: $e');
      throw e;
    }
  }

  Future<void> _fetchLeetCodePOTD() async {
    try {
      const String query = '''
        query questionOfToday {
          activeDailyCodingChallengeQuestion {
            date
            userStatus
            link
            question {
              acRate
              difficulty
              freqBar
              frontendQuestionId: questionFrontendId
              title
              titleSlug
              stats
              status
              topicTags {
                name
                id
                slug
              }
            }
          }
        }
      ''';

      final response = await http.post(
        Uri.parse('https://leetcode.com/graphql'),
        headers: {
          'Content-Type': 'application/json',
          'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36',
        },
        body: json.encode({
          'query': query,
          'variables': {},
        }),
      ).timeout(Duration(seconds: 15));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final questionData = jsonData['data']['activeDailyCodingChallengeQuestion'];
        final question = questionData['question'];

        setState(() {
          leetcodeProblemName = question['title'] ?? 'No Title Available';
          leetcodeDifficulty = question['difficulty'] ?? 'Unknown';
          leetcodeProblemUrl = 'https://leetcode.com${questionData['link']}';
          final acRate = double.tryParse(question['acRate'].toString()) ?? 0.0;
          leetcodeAcceptanceRate = '${acRate.toStringAsFixed(2)}%';
        });
      } else {
        throw Exception('Failed to load LeetCode POTD (Status: ${response.statusCode})');
      }
    } catch (e) {
      print('Debug - LeetCode Error: $e');
      throw e;
    }
  }
  Widget _buildProblemCard({
    required String title,
    required String problemName,
    required String difficulty,
    required String accuracy,
    required String url,
    required Color cardColor,
  }) {
    return Card(
      color: cardColor,
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 16),
            Text(
              problemName,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    difficulty,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(width: 8),
                if (accuracy.isNotEmpty)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      'Accuracy: $accuracy',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
              ],
            ),
            if (url.isNotEmpty) ...[
              SizedBox(height: 12),
              GestureDetector(
                onTap: () async {
                  final Uri _url = Uri.parse(url);
                  if (!await launchUrl(_url)) {
                    throw Exception('Could not launch $_url');
                  }
                },
                child: Text(
                  url,
                  style: TextStyle(
                    color: Colors.white70,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Problem of the Day'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _fetchAllProblems,
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : RefreshIndicator(
        onRefresh: _fetchAllProblems,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (errorMessage.isNotEmpty)
                Container(
                  padding: EdgeInsets.all(8.0),
                  margin: EdgeInsets.only(bottom: 16.0),
                  color: Colors.red[100],
                  child: Text(
                    errorMessage,
                    style: TextStyle(color: Colors.red[900]),
                  ),
                ),
              _buildProblemCard(
                title: 'GeeksforGeeks POTD',
                problemName: gfgProblemName,
                difficulty: gfgDifficulty,
                accuracy: gfgAccuracy,
                url: gfgProblemUrl,
                cardColor: Colors.green[700]!,
              ),
              _buildProblemCard(
                title: 'LeetCode POTD',
                problemName: leetcodeProblemName,
                difficulty: leetcodeDifficulty,
                accuracy: leetcodeAcceptanceRate,
                url: leetcodeProblemUrl,
                cardColor: Colors.orange[800]!,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CompareProfilesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Compare Profiles")),
      body: Center(child: Text("Compare Profiles Screen")),
    );
  }
}

class ChatRoomScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Chat Room")),
      body: Center(child: Text("Chat Room Screen")),
    );
  }
}
