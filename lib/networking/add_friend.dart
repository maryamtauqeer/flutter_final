import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_final/networking/dashboard.dart';
import 'package:flutter_final/networking/provider.dart';

import 'constants.dart';

class AddFriendsScreen extends StatefulWidget {
  @override
  _AddFriendsScreenState createState() => _AddFriendsScreenState();
}

class _AddFriendsScreenState extends State<AddFriendsScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  String nameError = '';
  String emailError = '';
  String phoneError = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text(
          'Add',
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
                // If input is valid, add friend to Firebase
                if (nameError.isEmpty &&
                    emailError.isEmpty &&
                    phoneError.isEmpty) {
                  _addFriendToFirebase();
                }
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                padding: EdgeInsets.all(16),
              ),
              child: Text(
                'Submit',
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

  Future<void> _addFriendToFirebase() async {
    // Get data from controllers
    String name = nameController.text;
    String email = emailController.text;
    String phone = phoneController.text;

    try {
      // Add friend to Firebase
      await FirebaseFirestore.instance.collection('friends').add({
        'name': name,
        'email': email,
        'phone': phone,
        'image':
            'https://images.unsplash.com/opengraph/1x1.png?blend=https%3A%2F%2Fimages.unsplash.com%2Fphoto-1438761681033-6461ffad8d80%3Fblend%3D000000%26blend-alpha%3D10%26blend-mode%3Dnormal%26crop%3Dfaces%252Cedges%26h%3D630%26mark%3Dhttps%253A%252F%252Fimages.unsplash.com%252Fopengraph%252Fsearch-input.png%253Fh%253D84%2526txt%253Duser%2526txt-align%253Dmiddle%25252Cleft%2526txt-clip%253Dellipsis%2526txt-color%253D000000%2526txt-pad%253D80%2526txt-size%253D40%2526txt-width%253D660%2526w%253D750%2526auto%253Dformat%2526fit%253Dcrop%2526q%253D60%26mark-align%3Dmiddle%252Ccenter%26mark-w%3D750%26w%3D1200%26auto%3Dformat%26fit%3Dcrop%26q%3D60%26ixid%3DM3wxMjA3fDB8MXxzZWFyY2h8Nnx8dXNlcnxlbnwwfHx8fDE3MDMwNDQ4MzR8MA%26ixlib%3Drb-4.0.3&blend-w=1&h=630&mark=https%3A%2F%2Fimages.unsplash.com%2Fopengraph%2Flogo.png&mark-align=top%2Cleft&mark-pad=50&mark-w=64&w=1200&auto=format&fit=crop&q=60'
      });

      // Navigate to the dashboard screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DashboardScreen()),
      );

      // Handle success or navigate to a success screen
      print('Friend added to Firebase: $name, $email, $phone');
    } catch (e) {
      // Handle error
      print('Error adding friend to Firebase: $e');
    }
  }
}

class TextFieldWithIcon extends StatelessWidget {
  final String label;
  final IconData icon;
  final TextEditingController controller;
  final String? errorText;

  const TextFieldWithIcon({
    required this.label,
    required this.icon,
    required this.controller,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: label,
            suffixIcon: Icon(icon),
          ),
        ),
        if (errorText != null && errorText!.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 4),
            child: Text(
              errorText!,
              style: TextStyle(color: Colors.red),
            ),
          ),
      ],
    );
  }
}
