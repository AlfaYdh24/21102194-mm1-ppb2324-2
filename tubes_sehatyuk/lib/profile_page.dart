import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:tubes_sehatyuk/login_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isLoading = false;
  late User _currentUser;
  late FirebaseFirestore _firestore;
  late FirebaseStorage _storage;

  String _displayName = '';
  String _phoneNumber = '';
  String _createdAt = '';
  String _profileImageUrl = '';
  String _gender = 'Perempuan'; // Example default value

  @override
  void initState() {
    super.initState();
    _firestore = FirebaseFirestore.instance;
    _storage = FirebaseStorage.instance;
    _currentUser = FirebaseAuth.instance.currentUser!;
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      DocumentSnapshot<Map<String, dynamic>> userData = await _firestore.collection('users').doc(_currentUser.uid).get();
      if (userData.exists) {
        Timestamp createdAtTimestamp = userData.get('createdAt');
        setState(() {
          _displayName = userData.get('displayName') ?? userData.get('name');
          _phoneNumber = userData.get('phoneNumber') ?? '';
          _createdAt = DateFormat('dd-MM-yyyy').format(createdAtTimestamp.toDate());
          _profileImageUrl = userData.get('profileImageUrl') ?? '';
          _gender = userData.get('gender') ?? 'Perempuan'; // Fetch gender from Firestore
        });
      }
    } catch (e) {
      print("Error fetching user data: $e");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _updateProfile(String field, String value) async {
    setState(() {
      _isLoading = true;
    });

    try {
      await _firestore.collection('users').doc(_currentUser.uid).update({
        field: value,
      });

      setState(() {
        if (field == 'name') _displayName = value;
        if (field == 'phoneNumber') _phoneNumber = value;
        if (field == 'gender') _gender = value;
        if (field == 'createdAt') _createdAt = value;
        // Note: Updating the email requires re-authentication, which is more complex.
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Profile updated successfully")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to update profile: $e")),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _updateProfileImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _isLoading = true;
      });

      try {
        File file = File(pickedFile.path);
        String fileName = _currentUser.uid + '.png';
        UploadTask uploadTask = _storage.ref('profile_images/$fileName').putFile(file);
        TaskSnapshot taskSnapshot = await uploadTask;
        String downloadUrl = await taskSnapshot.ref.getDownloadURL();

        await _firestore.collection('users').doc(_currentUser.uid).update({
          'profileImageUrl': downloadUrl,
        });

        setState(() {
          _profileImageUrl = downloadUrl;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Profile image updated successfully")),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to update profile image: $e")),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _editProfile(String field, String initialValue) async {
    TextEditingController controller = TextEditingController(text: initialValue);

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit $field'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  controller: controller,
                  decoration: InputDecoration(hintText: field),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Save'),
              onPressed: () {
                _updateProfile(field, controller.text);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _resetPassword() async {
    TextEditingController emailController = TextEditingController(text: _currentUser.email);

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Reset Password'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                const Text('Enter your email to reset password:'),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(hintText: 'Email'),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Send'),
              onPressed: () async {
                try {
                  await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Password reset email sent")),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Failed to send reset email: $e")),
                  );
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteAccount() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Account'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Are you sure you want to delete your account? This action cannot be undone.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
              onPressed: () async {
                setState(() {
                  _isLoading = true;
                });

                try {
                  await _firestore.collection('users').doc(_currentUser.uid).delete();

                  await _currentUser.delete();

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Account deleted successfully")),
                  );

                  Navigator.of(context).pop();

                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Failed to delete account: $e")),
                  );
                } finally {
                  setState(() {
                    _isLoading = false;
                  });
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _logout() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await FirebaseAuth.instance.signOut();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Successfully logged out")),
      );
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Logout failed: ${e.toString()}")),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Profile',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(
            color: Colors.white,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Color(0xFFD9D9D9),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: GestureDetector(
                            onTap: _updateProfileImage,
                            child: CircleAvatar(
                              radius: 60,
                              backgroundImage: _profileImageUrl.isNotEmpty
                                  ? NetworkImage(_profileImageUrl)
                                  : AssetImage('images/profile.png') as ImageProvider,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        _buildProfileItem('Nama', _displayName, () => _editProfile('name', _displayName)),
                        const Divider(),
                        _buildProfileItem('Tanggal Lahir', _createdAt, () => _editProfile('createdAt', _createdAt)),
                        const Divider(),
                        _buildProfileItem('Jenis Kelamin', _gender, () => _editProfile('gender', _gender)),
                        const Divider(),
                        _buildProfileItem('Email', _currentUser.email ?? '', _resetPassword),
                        const Divider(),
                        _buildProfileItem('Nomor HP', _phoneNumber, () => _editProfile('phoneNumber', _phoneNumber)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        icon: Icon(Icons.logout, color: Colors.black),
                        onPressed: _logout,
                        tooltip: 'Logout',
                      ),
                      IconButton(
                        icon: Icon(Icons.lock_reset, color: Colors.black),
                        onPressed: _resetPassword,
                        tooltip: 'Reset Password',
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: _deleteAccount,
                        tooltip: 'Delete Account',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildProfileItem(String title, String value, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 3,
            child: Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(
              value,
              style: TextStyle(fontSize: 16),
            ),
          ),
          TextButton(
            onPressed: onTap,
            child: Text('Ubah', style: TextStyle(color: Colors.green)),
          ),
        ],
      ),
    );
  }
}
