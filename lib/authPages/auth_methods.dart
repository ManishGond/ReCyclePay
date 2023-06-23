import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

class User {
  final String id;
  final String username;
  final String email;
  final String bio;
  final String photoUrl;

  User({
    String? id,
    required this.username,
    required this.email,
    required this.bio,
    required this.photoUrl,
  }) : id = id ?? const Uuid().v4();

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      bio: json['bio'],
      photoUrl: json['photoUrl'],
    );
  }
}

class AuthMethods {
  static const String apiUrl =
      'http://your-fastapi-url'; // Update with your FastAPI server URL

  Future<User> getUserDetails() async {
    try {
      final response = await http.get(Uri.parse('$apiUrl/users'));
      if (response.statusCode == 200) {
        final userDetails = json.decode(response.body);
        return User.fromJson(userDetails);
      } else {
        throw Exception('Failed to fetch user details');
      }
    } catch (err) {
      throw err.toString();
    }
  }

  Future<String> signupUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  }) async {
    String res = "Some error Occurred";
    try {
      if (email.isNotEmpty &&
          password.isNotEmpty &&
          username.isNotEmpty &&
          bio.isNotEmpty) {
        var request =
            http.MultipartRequest('POST', Uri.parse('$apiUrl/signup'));

        request.fields['email'] = email;
        request.fields['password'] = password;
        request.fields['username'] = username;
        request.fields['bio'] = bio;

        var pic = http.MultipartFile.fromBytes('profilePic', file,
            filename: 'profilePic.jpg');
        request.files.add(pic);

        var response = await request.send();
        if (response.statusCode == 200) {
          res = "success";
        } else {
          res = "Some error occurred";
        }
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  Future<String> signinUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error Occurred";
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        var response = await http.post(
          Uri.parse('$apiUrl/login'),
          body: {
            'email': email,
            'password': password,
          },
        );

        if (response.statusCode == 200) {
          res = "success";
        } else {
          res = "Invalid credentials";
        }
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  Future<void> signOut() async {
    // Implement your sign-out logic here
  }

  Future<String> updateUserProfile({
    required String displayName,
    required String photoUrl,
  }) async {
    try {
      final response = await http.put(
        Uri.parse('$apiUrl/users'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'displayName': displayName,
          'photoUrl': photoUrl,
        }),
      );

      if (response.statusCode == 200) {
        return 'success';
      } else {
        return 'Failed to update user profile';
      }
    } catch (err) {
      return err.toString();
    }
  }
}
