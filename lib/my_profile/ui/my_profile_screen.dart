import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../data/database_helper.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({Key? key}) : super(key: key);

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  late File _selectedImage;
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController clubController = TextEditingController();
  TextEditingController varsityController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  bool _isUpdating = false;

  @override
  void initState() {
    super.initState();
    _selectedImage = File("assets/default_profile_pic.jpg");
    _loadUserProfileData();
  }

  Future<void> _loadUserProfileData() async {
    await _databaseHelper.initializeDatabase();
    final userProfile = await _databaseHelper.getUserProfile();

    setState(() {
      fullNameController.text = userProfile['fullName'] ?? "John Doe";
      emailController.text = userProfile['email'] ?? "john.doe@example.com";
      phoneNumberController.text = userProfile['phoneNumber'] ?? "+1234567890";
      bioController.text = userProfile['bio'] ?? "This is my bio.";
      genderController.text = userProfile['gender'] ?? "Male";
      clubController.text = userProfile['club'] ?? "Club Name";
      varsityController.text = userProfile['varsity'] ?? "University Name";
      // Set the profile image path
      _selectedImage = File(userProfile['profileImagePath'] ?? "assets/default_profile_pic.jpg");
    });
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  void _updateProfile() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isUpdating = true;
      });

      final updatedProfile = {
        'fullName': fullNameController.text,
        'email': emailController.text,
        'phoneNumber': phoneNumberController.text,
        'bio': bioController.text,
        'gender': genderController.text,
        'club': clubController.text,
        'varsity': varsityController.text,
        'profileImagePath': _selectedImage.path, // Save the image path
      };


      await _databaseHelper.insertUserProfile(updatedProfile);

      setState(() {
        _isUpdating = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Profile Updated'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => _pickImage(),
                  child: Hero(
                    tag: 'profile-image',
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: _selectedImage.existsSync()
                          ? FileImage(_selectedImage) as ImageProvider<Object>?
                          : AssetImage("assets/images/img.png") as ImageProvider<Object>?,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Tap to change profile picture",
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: fullNameController,
                  decoration: InputDecoration(labelText: 'Full Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your full name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value == null || value.isEmpty || !value.contains('@')) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: phoneNumberController,
                  decoration: InputDecoration(labelText: 'Phone Number'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: bioController,
                  decoration: InputDecoration(labelText: 'Bio'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your bio';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: genderController,
                  decoration: InputDecoration(labelText: 'Gender'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your gender';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: clubController,
                  decoration: InputDecoration(labelText: 'Club'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your club';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: varsityController,
                  decoration: InputDecoration(labelText: 'Varsity'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your varsity';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _isUpdating ? null : _updateProfile,
                  child: _isUpdating
                      ? SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      color: Colors.white,
                    ),
                  )
                      : Text("Update Profile"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
