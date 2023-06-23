import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  void saveProfileChanges() {
    String name = _nameController.text;
    String bio = _bioController.text;

    // Example of how to use the profile data
    if (kDebugMode) {
      print('Name: $name');
      print('Bio: $bio');
    }

    // Create a map to pass multiple profile changes
    Map<String, String> profileChanges = {
      'name': name,
      'bio': bio,
    };

    // Pass the updated profile changes back to the ProfilePage
    Navigator.pop(context, profileChanges);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
              ),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _bioController,
              decoration: const InputDecoration(
                labelText: 'Bio',
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: saveProfileChanges,
              child: const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
