import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../authentication/firebase_auth_implementation/firebase_auth_services.dart';
import '../theme/theme_provider.dart';
import '../userDetails/user_services.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String firstName = "";
  String lastName = "";
  String email = "";
  String contactNumber = "";

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _contactNumberController = TextEditingController();
  final TextEditingController _currentPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  File? _profileImage;

  String errorMessage = "";
  bool isSuccessMessageVisible = false;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    UserService userService = UserService();
    Map<String, dynamic>? userData = await userService.getUserDetails();

    if (userData != null) {
      setState(() {
        firstName = userData['firstName'] ?? '';
        lastName = userData['lastName'] ?? '';
        email = userData['email'] ?? '';
        contactNumber = userData['contactNo'] ?? '';

        _firstNameController.text = firstName;
        _lastNameController.text = lastName;
        _contactNumberController.text = contactNumber;
      });
    }
  }

  Future<void> _changePassword(String currentPassword, String newPassword) async {
    FirebaseAuthService authService = FirebaseAuthService();
    try {
      await authService.changePassword(currentPassword, newPassword);
      setState(() {
        errorMessage = 'Password changed successfully!';
        isSuccessMessageVisible = true;
      });
    } catch (e) {
      setState(() {
        isSuccessMessageVisible = false;
        errorMessage = 'Incorrect Current Password';
      });
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Text('Profile', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: Icon(
              themeProvider.themeData.brightness == Brightness.dark
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
            onPressed: () {
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
            },
          ),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 70,
                  backgroundImage: _profileImage != null
                      ? FileImage(_profileImage!)
                      : AssetImage('assets/images/userProfile_MAD.jpg') as ImageProvider,
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    _showImageSourceActionSheet(context);
                  },
                  child: Text('Change Profile Image'),
                ),

                const SizedBox(height: 20),

                Text(
                  '$firstName $lastName',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),

                Text(
                  email,
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
                const SizedBox(height: 30),

                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Personal Information',
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      ),

                      const SizedBox(height: 10),

                      TextField(
                        controller: _firstNameController,
                        decoration: InputDecoration(
                          labelText: 'First Name',
                          prefixIcon: Icon(Icons.person),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      TextField(
                        controller: _lastNameController,
                        decoration: InputDecoration(
                          labelText: 'Last Name',
                          prefixIcon: Icon(Icons.person_outline),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      TextField(
                        controller: _contactNumberController,
                        decoration: InputDecoration(
                          labelText: 'Contact Number',
                          prefixIcon: Icon(Icons.phone),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                        ),
                        onPressed: () async {
                          setState(() {
                            firstName = _firstNameController.text;
                            lastName = _lastNameController.text;
                            contactNumber = _contactNumberController.text;
                          });

                          UserService userService = UserService();
                          await userService.updateUserDetails(firstName, lastName, contactNumber);

                          print('Personal information updated');
                        },
                        child: Text('Save Changes'),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Password Recovery',
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      ),

                      const SizedBox(height: 10),

                      TextField(
                        controller: _currentPasswordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Current Password',
                          prefixIcon: Icon(Icons.lock),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      TextField(
                        controller: _newPasswordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'New Password',
                          prefixIcon: Icon(Icons.lock_outline),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),

                      TextField(
                        controller: _confirmPasswordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Confirm New Password',
                          prefixIcon: Icon(Icons.lock_outline),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Error message display
                      if (errorMessage.isNotEmpty)
                        Text(
                          errorMessage,
                          style: TextStyle(
                            color: isSuccessMessageVisible ? Colors.green : Colors.red, // Change color based on success
                            fontSize: 14,
                          ),
                        ),

                      const SizedBox(height: 20),

                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                        ),
                        onPressed: () async {
                          String currentPassword = _currentPasswordController.text;
                          String newPassword = _newPasswordController.text;
                          String confirmPassword = _confirmPasswordController.text;

                          setState(() {
                            isSuccessMessageVisible = false;
                            if (newPassword.isEmpty || confirmPassword.isEmpty || currentPassword.isEmpty) {
                              errorMessage = "All fields are required";
                            } else if (newPassword != confirmPassword) {
                              errorMessage = "New password and confirmation do not match";
                            } else {
                              errorMessage = "";
                            }
                          });

                          if (errorMessage.isEmpty) {
                            await _changePassword(currentPassword, newPassword);

                            _currentPasswordController.clear();
                            _newPasswordController.clear();
                            _confirmPasswordController.clear();
                          }
                        },
                        child: Text('Change Password'),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showImageSourceActionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text('Gallery'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text('Camera'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _contactNumberController.dispose();
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
