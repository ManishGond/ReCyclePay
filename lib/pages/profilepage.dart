import 'package:flutter/material.dart';
import '../authPages/auth_methods.dart';
import 'editprofile.dart';
import 'package:http/http.dart' as http;

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isFollowing = false;
  String profileName = '';
  String profileBio = '';
  User? currentUser;
  final authMethods = AuthMethods();
  final String apiUrl = 'https://your-api-url.com';

  void toggleFollow() {
    setState(() {
      isFollowing = !isFollowing;
    });
  }

  void navigateToEditProfile() async {
    final profileChanges = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditProfilePage()),
    );

    if (profileChanges != null) {
      setState(() {
        profileName = profileChanges['name'];
        profileBio = profileChanges['bio'];
        // Update the user profile using the API
        updateUserProfile(profileName, profileBio);
      });
    }
  }

  Future<void> updateUserProfile(String displayName, String bio) async {
    try {
      // Update the user profile using the API
      final response = await http.put(
        Uri.parse('$apiUrl/users/${currentUser!.id}'),
        body: {
          'username': displayName,
          'bio': bio,
        },
      );

      if (response.statusCode == 200) {
        // Refresh the user details from the API
        final updatedUser = await getUserProfile();

        setState(() {
          // Update the current user and profile information
          currentUser = updatedUser;
          profileName = currentUser!.username;
          profileBio = currentUser!.bio;
        });
      } else {
        throw Exception('Failed to update user profile');
      }
    } catch (e) {
      // Handle any errors that occur during the update process
      print('Error updating user profile: $e');
      throw Exception('Failed to update user profile');
    }
  }

  @override
  void initState() {
    super.initState();
    // Fetch the user details from the API when the widget initializes
    getUserProfile();
  }

  Future<User> getUserProfile() async {
    try {
      final userDetails = await authMethods.getUserDetails();
      setState(() {
        currentUser = userDetails;
        profileName = currentUser!.username;
        profileBio = currentUser!.bio;
      });
      return userDetails;
    } catch (e) {
      print('Error fetching user profile: $e');
      throw Exception('Failed to fetch user profile');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            color: Colors.black,
            onPressed: () {
              // Implement the share functionality here
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            height: 250,
            decoration: const BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                image: AssetImage('assets/images/map.PNG'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 200,
            child: GestureDetector(
              onTap: () {
                // Implement the logic to change the avatar here
              },
              child: const Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/images/profile.jpg'),
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.only(
              top: 310,
              left: 20,
              right: 20,
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    profileName,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '1003 followers',
                        style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 6),
                      Text(
                        '50 following',
                        style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            navigateToEditProfile();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(color: Colors.grey.shade100),
                            ),
                            minimumSize: const Size(
                              100,
                              30,
                            ),
                          ),
                          child: const Text(
                            'Report Issue',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(color: Colors.grey.shade100),
                            ),
                            minimumSize: const Size(
                              100,
                              30,
                            ),
                          ),
                          child: const Text(
                            'History',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () {
                            navigateToEditProfile();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(color: Colors.grey.shade100),
                            ),
                            minimumSize: const Size(
                              100,
                              30,
                            ),
                          ),
                          child: const Text(
                            'Edit Profile',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 9),
                  const Text(
                    '📍 Bengaluru',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 18),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      profileBio,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
