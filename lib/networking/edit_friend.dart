import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_final/networking/add_friend.dart';
import 'package:flutter_final/networking/dashboard.dart';
import 'package:flutter_final/networking/model.dart';
import 'package:flutter_final/networking/provider.dart';

import 'constants.dart';

class EditFriendsScreen extends StatefulWidget {
  final Friend friend;

  EditFriendsScreen({required this.friend});

  @override
  _EditFriendsScreenState createState() => _EditFriendsScreenState();
}

class _EditFriendsScreenState extends State<EditFriendsScreen> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;

  String nameError = '';
  String emailError = '';
  String phoneError = '';

  @override
  void initState() {
    super.initState();

    // Initialize controllers with existing friend details
    nameController = TextEditingController(text: widget.friend.name);
    emailController = TextEditingController(text: widget.friend.email);
    phoneController = TextEditingController(text: widget.friend.phone);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text(
          'Edit',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFieldWithIcon(
              label: 'Name',
              icon: Icons.person,
              controller: nameController,
              errorText: nameError,
            ),
            SizedBox(height: 16),
            TextFieldWithIcon(
              label: 'Email',
              icon: Icons.email,
              controller: emailController,
              errorText: emailError,
            ),
            SizedBox(height: 16),
            TextFieldWithIcon(
              label: 'Phone number',
              icon: Icons.phone,
              controller: phoneController,
              errorText: phoneError,
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                // Validate input
                _validateInput();
                // If input is valid, save changes to Firebase
                if (nameError.isEmpty &&
                    emailError.isEmpty &&
                    phoneError.isEmpty) {
                  _saveChangesToFirebase();
                }
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                padding: EdgeInsets.all(16),
              ),
              child: Text(
                'Save',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _validateInput() {
    setState(() {
      nameError =
          nameController.text.isValidName() ? '' : 'Invalid name entered!';
      emailError =
          emailController.text.isValidEmail() ? '' : 'Invalid email entered!';
      phoneError = phoneController.text.isValidPhone()
          ? ''
          : 'Invalid phone number entered!';
    });
  }

  Future<void> _saveChangesToFirebase() async {
    // Get data from controllers
    String name = nameController.text;
    String email = emailController.text;
    String phone = phoneController.text;

    try {
      // Reference to the friends collection in Firebase
      final friendsCollection =
          FirebaseFirestore.instance.collection('friends');

      // Find the document associated with the friend
      final friendDocs = await friendsCollection
          .where('name', isEqualTo: widget.friend.name)
          .where('email', isEqualTo: widget.friend.email)
          .where('phone', isEqualTo: widget.friend.phone)
          .limit(1)
          .get();

      // Check if a matching document is found
      if (friendDocs.docs.isNotEmpty) {
        // Update the document in Firebase
        await friendDocs.docs.first.reference.update({
          'name': name,
          'email': email,
          'phone': phone,
        });
      }

      // Navigate back to the dashboard screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DashboardScreen()),
      );

      // Handle success or navigate to a success screen
      print('Friend details updated in Firebase: $name, $email, $phone');
    } catch (e) {
      // Handle error
      print('Error updating friend details in Firebase: $e');
    }
  }
}
