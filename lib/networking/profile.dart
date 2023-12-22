import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      // Wrap your Container with Material
      child: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              CircleAvatar(
                radius: 80,
                backgroundImage: NetworkImage(
                    'https://img.freepik.com/premium-vector/hand-drawing-cartoon-girl-cute-girl-drawing-profile-picture_488586-692.jpg?w=2000'),
              ),
              SizedBox(height: 20),
              Text(
                'Maryam',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text('tauqeermaryam741@gmail.com'),
              SizedBox(height: 8),
              Text(
                'IBA Student, Computer Science and Flutter App Development',
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              _buildListTile(Icons.lock, 'Privacy', context),
              _buildListTile(Icons.help, 'Help & Support', context),
              _buildListTile(Icons.settings, 'Settings', context),
              _buildListTile(Icons.person_add, 'Invite a Friend', context),
              _buildListTile(Icons.exit_to_app, 'Logout', context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListTile(IconData icon, String title, BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.white),
        title: Text(title, style: TextStyle(color: Colors.white)),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.white),
        onTap: () {
          // Handle onTap for each list tile
          // You can navigate to different screens or perform specific actions
          // based on the selected list tile
          switch (title) {
            case 'Privacy':
              // Handle privacy action
              break;
            case 'Help & Support':
              // Handle help & support action
              break;
            case 'Settings':
              // Handle settings action
              break;
            case 'Invite a Friend':
              // Handle invite a friend action
              break;
            case 'Logout':
              // Handle logout action
              break;
            default:
              break;
          }
        },
      ),
    );
  }
}
