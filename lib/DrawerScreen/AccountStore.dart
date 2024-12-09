import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _leetcodeController = TextEditingController();
  final TextEditingController _gfgController = TextEditingController();
  final TextEditingController _codeforcesController = TextEditingController();

  Map<String, dynamic> profileData = {};
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    loadUserProfiles();
  }

  Future<Map<String, dynamic>> fetchLeetcodeStats(String username) async {
    try {
      final response = await http.post(
        Uri.parse('https://leetcode.com/graphql'),
        headers: {
          'Content-Type': 'application/json',
          'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36',
        },
        body: json.encode({
          'query': r'''
        query userProfile($username: String!) {
          matchedUser(username: $username) {
            username
            submitStats {
              acSubmissionNum {
                difficulty
                count
              }
              totalSubmissionNum {
                count
              }
            }
            profile {
              ranking
            }
          }
        }
      ''',
          'variables': {'username': username},
        }),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed with status: ${response.statusCode}');
      }

      var data = json.decode(response.body);
      var userData = data['data']['matchedUser'];
      if (userData == null) return _defaultResponse(username);

      var submitStats = userData['submitStats'];
      var acSubmissionNum = submitStats['acSubmissionNum'];

      var totalSolved = acSubmissionNum[0]['count'];

      var totalSubmissions = submitStats['totalSubmissionNum'][0]['count'];

      return {
        'username': username,
        'solved': totalSolved,
        'ranking': userData['profile']['ranking']?.toString() ?? 'N/A',
        'totalSubmissions': totalSubmissions,
        // 'rating': userData['profile']['ranking']?.toString() ?? 'N/A',
      };
    } catch (e) {
      print('Error fetching LeetCode stats: $e');
      return _defaultResponse(username);
    }
  }

  Map<String, dynamic> _defaultResponse(String username) => {
    'username': username,
    'solved': 0,
    'ranking': 'N/A',
    'totalSubmissions': 0,
  };

  Future<Map<String, dynamic>> fetchCodeforcesStats(String handle) async {
    try {
      final response = await http.get(
        Uri.parse('https://codeforces.com/api/user.info?handles=$handle'),
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        var userData = data['result']?.first;

        return {
          'handle': handle,
          'rating': userData?['rating'] ?? 0,
          'rank': userData?['rank'] ?? 'N/A',
          'maxRating': userData?['maxRating'] ?? 0,
        };
      }
      return {
        'handle': handle,
        'rating': 0,
        'rank': 'N/A',
        'maxRating': 0,
      };
    } catch (e) {
      // print('Error fetching Codeforces stats: $e');
      return {
        'handle': handle,
        'rating': 0,
        'rank': 'N/A',
        'maxRating': 0,
      };
    }
  }



  Future<void> loadUserProfiles() async {
    if (!mounted) return;

    setState(() {
      isLoading = true;
    });

    try {
      var db = await mongo.Db.create(
          'mongodb+srv://daksheshgupta4:Dakshesh30!@cluster0.itpg4.mongodb.net/?retryWrites=true&w=majority&ssl=true&tlsAllowInvalidCertificates=true&appName=Cluster0'
      );
      await db.open();
      var collection = db.collection('user_profiles');

      var userData = await collection.findOne(
          mongo.where.eq('userId', FirebaseAuth.instance.currentUser?.uid)
      );

      if (userData != null && mounted) {
        setState(() {
          _leetcodeController.text = userData['leetcode'] ?? '';
          _gfgController.text = userData['gfg'] ?? '';
          _codeforcesController.text = userData['codeforces'] ?? '';
          profileData = userData['profileData'] ?? {};
        });

        if (_leetcodeController.text.isNotEmpty) {
          var leetcodeData = await fetchLeetcodeStats(_leetcodeController.text);
          setState(() {
            profileData['leetcode'] = leetcodeData;
          });
        }

        if (_codeforcesController.text.isNotEmpty) {
          var codeforcesData = await fetchCodeforcesStats(_codeforcesController.text);
          setState(() {
            profileData['codeforces'] = codeforcesData;
          });
        }
      }
      var allProfiles = await collection.find().toList();
      for (var profile in allProfiles) {
        print('Profile Data: $profile');
      }
      await db.close();
    } catch (e, stackTrace) {
      print('Error: $e');
      print('Stack trace: $stackTrace');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error loading profiles: $e'))
        );
      }
    }

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<bool> validateLeetcodeId(String username) async {
    try {
      final response = await http.post(
        Uri.parse('https://leetcode.com/graphql'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'query': '''
            query userProfile(\$username: String!) {
              matchedUser(username: \$username) {
                username
              }
            }
          ''',
          'variables': {'username': username},
        }),
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        return data['data']['matchedUser'] != null;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> validateCodeforcesId(String handle) async {
    try {
      final response = await http.get(
          Uri.parse('https://codeforces.com/api/user.info?handles=$handle')
      );
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  Future<void> saveProfiles() async {
    if (!_formKey.currentState!.validate()) return;

    if (!mounted) return;

    setState(() {
      isLoading = true;
    });

    try {
      if (_leetcodeController.text.isNotEmpty) {
        bool isLeetcodeValid = await validateLeetcodeId(_leetcodeController.text);
        if (!isLeetcodeValid) {
          throw Exception('Invalid LeetCode username');
        }
      }

      if (_codeforcesController.text.isNotEmpty) {
        bool isCodeforcesValid = await validateCodeforcesId(_codeforcesController.text);
        if (!isCodeforcesValid) {
          throw Exception('Invalid Codeforces handle');
        }
      }

      // if (_gfgController.text.isNotEmpty) {
      //   bool isGfgValid = await validateGfgId(_codeforcesController.text);
      //   if (!isGfgValid) {
      //     throw Exception('Invalid Codeforces handle');
      //   }
      // }

      Map<String, dynamic> leetcodeData = {};
      Map<String, dynamic> codeforcesData = {};
      Map<String,dynamic>gfgData={};

      if (_leetcodeController.text.isNotEmpty) {
        leetcodeData = await fetchLeetcodeStats(_leetcodeController.text);
      }

      if (_codeforcesController.text.isNotEmpty) {
        codeforcesData = await fetchCodeforcesStats(_codeforcesController.text);
      }

      var db = await mongo.Db.create('mongodb+srv://daksheshgupta4:Dakshesh30!@cluster0.itpg4.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0');
      await db.open();
      var collection = db.collection('user_profiles');

      await collection.update(
          mongo.where.eq('userId', FirebaseAuth.instance.currentUser?.uid),
          {
            '\$set': {
              'leetcode': _leetcodeController.text,
              'gfg': _gfgController.text,
              'codeforces': _codeforcesController.text,
              'profileData': {
                'leetcode': leetcodeData,
                'codeforces': codeforcesData,
                'gfg':gfgData,
              },
            }
          },
          upsert: true
      );

      setState(() {
        profileData = {
          'leetcode': leetcodeData,
          'codeforces': codeforcesData,
          'gfg':gfgData,
        };
      });

      await db.close();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Profiles saved and updated successfully!'))
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error saving profiles: $e'))
        );
      }
    }

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff171d28),
      appBar: AppBar(
        backgroundColor: Color(0xff171d28),
        title: Text('Profile Settings',
            style: TextStyle(color: Colors.white)
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            if (profileData.isNotEmpty) ...[
              if (profileData['leetcode'] != null && profileData['leetcode']['username'] != null)
                ProfileCard(
                  platformName: 'LeetCode',
                  username: profileData['leetcode']['username'],
                  solved: profileData['leetcode']['solved'],
                  ranking: profileData['leetcode']['ranking'],
                  stats: {
                    'Total Submissions': profileData['leetcode']['totalSubmissions']?.toString() ?? 'N/A',
                  },

                ),
              SizedBox(height: 16),
              if (profileData['codeforces'] != null && profileData['codeforces']['handle'] != null)
                ProfileCard(
                  platformName: 'CodeForces',
                  username: profileData['codeforces']['handle'],
                  rating: profileData['codeforces']['rating'],
                  rank: profileData['codeforces']['rank'],
                  stats: {
                    'Max Rating': profileData['codeforces']['maxRating']?.toString() ?? 'N/A',
                  },
                ),
              SizedBox(height: 24),
            ],
            Form(
              key: _formKey,
              child: Column(
                children: [
                  PlatformTextField(
                    controller: _leetcodeController,
                    platform: 'LeetCode',
                    icon: 'assets/CodingPlatformsIcons/img.png',
                  ),
                  SizedBox(height: 16),
                  PlatformTextField(
                    controller: _gfgController,
                    platform: 'GeeksforGeeks',
                    icon: 'assets/CodingPlatformsIcons/img_6.png',
                  ),
                  SizedBox(height: 16),
                  PlatformTextField(
                    controller: _codeforcesController,
                    platform: 'CodeForces',
                    icon: 'assets/CodingPlatformsIcons/img_5.png',
                  ),
                  SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: isLoading ? null : saveProfiles,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    ),
                    child: isLoading
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text('Save Profiles'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _leetcodeController.dispose();
    _gfgController.dispose();
    _codeforcesController.dispose();
    super.dispose();
  }
}

class ProfileCard extends StatelessWidget {
  final String platformName;
  final String username;
  final int? solved;
  final int? rating;
  final String? ranking;
  final String? rank;
  final Map<String, String>? stats;

  const ProfileCard({
    Key? key,
    required this.platformName,
    required this.username,
    this.solved,
    this.rating,
    this.ranking,
    this.rank,
    this.stats,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue[800]!,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              platformName,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              '@$username',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                if (solved != null)
                  StatBox(
                    label: 'Problems Solved',
                    value: solved.toString(),
                  ),
                if (rating != null)
                  StatBox(
                    label: 'Rating',
                    value: rating.toString(),
                  ),
                if (ranking != null)
                  StatBox(
                    label: 'Ranking',
                    value: ranking!,
                  ),
                if (rank != null)
                  StatBox(
                    label: 'Rank',
                    value: rank!,
                  ),
                ...?stats?.entries.map(
                      (entry) => StatBox(
                    label: entry.key,
                    value: entry.value,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
class StatBox extends StatelessWidget {
  final String label;
  final String value;

  const StatBox({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: Colors.white70,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

class PlatformTextField extends StatelessWidget {
  final TextEditingController controller;
  final String platform;
  final String icon;

  const PlatformTextField({
    Key? key,
    required this.controller,
    required this.platform,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: '$platform Username',
        labelStyle: TextStyle(color: Colors.white70),
        prefixIcon: Padding(
          padding: EdgeInsets.all(12),
          child: Image.asset(icon, width: 24, height: 24),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.white30),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.white30),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.blue),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $platform username';
        }
        return null;
      },
    );
  }
}