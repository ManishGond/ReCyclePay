import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:testproject/authPages/auth_methods.dart';
import 'package:testproject/components/my_textfield.dart';
import 'package:testproject/components/square_time.dart';
import 'package:testproject/components/utils.dart';

import '../components/textedit.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({Key? key, required this.onTap}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final userNameController = TextEditingController();
  final bioController = TextEditingController();
  final phoneNumberController = TextEditingController();
  Uint8List? _image;
  bool isLoading = false;

  void wrongPasswordMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          title: Text('Incorrect Password'),
        );
      },
    );
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  void signupUser() async {
    if (_image == null) {
      showSnackBar(context, 'Please select a profile image');
      return;
    }
    if (!validateEmail(emailController.text)) {
      showSnackBar(context, 'Please enter a valid email address');
      return;
    }
    if (!validatePhoneNumber(phoneNumberController.text)) {
      showSnackBar(context, 'Please enter a valid phone number');
      return;
    }
    setState(() {
      isLoading = true;
    });
    String res = await AuthMethods().signupUser(
      email: emailController.text,
      password: passwordController.text,
      username: userNameController.text,
      bio: bioController.text,
      file: _image!,
    );
    if (res != "success") {
      showSnackBar(context, res);
      setState(() {
        isLoading = false;
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  bool validateEmail(String value) {
    String pattern =
        r'^[a-zA-Z0-9.!#$%&’+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)$';
    RegExp regex = new RegExp(pattern);
    return regex.hasMatch(value);
  }

  bool validatePhoneNumber(String value) {
    String pattern = r'^(\+91|0)?[6-9]\d{9}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 25),
                Stack(
                  children: [
                    _image != null
                        ? CircleAvatar(
                            radius: 64,
                            backgroundImage: MemoryImage(_image!),
                            backgroundColor: Colors.white,
                          )
                        : const CircleAvatar(
                            radius: 64,
                            backgroundImage:
                                AssetImage('assets/authLogo/default_image.png'),
                            backgroundColor: Colors.white,
                          ),
                    Positioned(
                      bottom: -10,
                      left: 80,
                      child: IconButton(
                        onPressed: selectImage,
                        icon: const Icon(Icons.add_a_photo),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 25),
                MyTextField(
                  controller: userNameController,
                  hintText: 'User Name', // Added display name field
                  obscureText: false,
                ),
                const SizedBox(height: 10),
                // Email field
                MyTextField(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                ),
                const SizedBox(height: 10),
                // Password field
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),
                const SizedBox(height: 10),
                MyPhoneTextField(
                  controller: phoneNumberController,
                  hintText: 'Phone Number',
                  obscureText: false,
                  inputType: TextInputType.phone, // Specify TextInputType.phone
                ),
                const SizedBox(height: 10),
                MyTextField(
                  controller: bioController,
                  hintText: 'About You',
                  obscureText: false,
                ),
                const SizedBox(height: 10),

                InkWell(
                  onTap: signupUser,
                  child: Container(
                    padding: const EdgeInsets.all(25),
                    margin: const EdgeInsets.symmetric(horizontal: 25),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: isLoading
                          ? const Center(
                              child: SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              ),
                            )
                          : const Text(
                              'Register Now',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Or continue with',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Google button
                    SquareTile(imagePath: 'assets/authLogo/google.png'),

                    SizedBox(width: 25),

                    // Apple button
                    SquareTile(imagePath: 'assets/authLogo/apple.png'),
                  ],
                ),

                const SizedBox(height: 25),

                // Not a member
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already a member?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
