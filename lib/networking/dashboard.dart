import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_final/networking/add_friend.dart';
import 'package:flutter_final/networking/api_sreeen.dart';
import 'package:flutter_final/networking/bottom_navbar.dart';
import 'package:flutter_final/networking/edit_friend.dart';
import 'package:flutter_final/networking/login.dart';
import 'package:flutter_final/networking/model.dart';
import 'package:flutter_final/networking/profile.dart';
import 'package:flutter_final/networking/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

// final List<Widget> _screens = [
//   DashboardScreen(),
//   ProfileScreen(),
// ];

class DashboardScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(currentIndexProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(currentIndex == 1 ? 'Profile' : 'Friends',
            style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddFriendsScreen()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.exit_to_app, color: Colors.white),
            onPressed: () async {
              // Sign out when the button is pressed
              await ref.read(authServiceProvider).signOut();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
          ),
        ],
      ),
      body: currentIndex == 1
          ? _buildProfileScreen()
          : currentIndex == 2
              ? _buildAPIScreen()
              : _buildDashboardScreen(ref),
      bottomNavigationBar: BottomNavBar(),
    );
  }

  Widget _buildDashboardScreen(WidgetRef ref) {
    AsyncValue<List<Friend>> friendsList = ref.watch(friendsProvider);
    int selectedViewIndex = ref.watch(selectedViewIndexProvider);

    return Column(
      children: [
        SizedBox(height: 10),
        Expanded(
          child: friendsList.when(
            loading: () => Center(child: CircularProgressIndicator()),
            error: (error, stack) => Text('Error: $error'),
            data: (friends) {
              print("Friends: $friends");
              return selectedViewIndex == 0
                  ? _buildListView(friends)
                  : _buildGridView(friends);
            },
          ),
        ),
        SizedBox(height: 10),
        _buildToggleButtons(selectedViewIndex, ref),
      ],
    );
  }

  Widget _buildProfileScreen() {
    // Return the widget for the profile screen
    print('Building Profile Screen');
    showToast('Building Profile Screen');
    return ProfileScreen();
  }

  Widget _buildAPIScreen() {
    // Return the widget for the PI screen
    print('Building API Screen');
    showToast('Building API Screen');
    return APIScreen();
  }

  Widget _buildFriendCard(BuildContext context, Friend friend) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EditFriendsScreen(friend: friend),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 30, 29, 29).withOpacity(0.2),
              spreadRadius: 0.01,
              blurRadius: 15,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 0.0,
          margin: EdgeInsets.zero,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: CircleAvatar(
                  radius: 30.0,
                  backgroundImage: NetworkImage(friend.image),
                ),
              ),
              SizedBox(height: 6.0),
              Text(
                friend.name,
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 4.0),
              Text(friend.email, style: TextStyle(fontSize: 13.0)),
              SizedBox(height: 4.0),
              Text(friend.phone, style: TextStyle(fontSize: 13.0)),
              SizedBox(height: 2.0),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  _deleteFriendFromFirebase(friend);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _deleteFriendFromFirebase(Friend friend) async {
    try {
      final friendsCollection =
          FirebaseFirestore.instance.collection('friends');

      final friendDoc = await friendsCollection
          .where('name', isEqualTo: friend.name)
          .limit(1)
          .get();

      if (friendDoc.docs.isNotEmpty) {
        await friendDoc.docs.first.reference.delete();
      }

      print('Friend deleted from Firebase: ${friend.name}');
      showToast('Friend deleted from Firebase: ${friend.name}');
    } catch (e) {
      showToast('Error deleting friend from Firebase: $e');
      print('Error deleting friend from Firebase: $e');
    }
  }

  Widget _buildListView(List<Friend> friends) {
    return ListView.builder(
      itemCount: friends.length,
      itemBuilder: (context, index) {
        return _buildFriendCard(context, friends[index]);
      },
    );
  }

  Widget _buildGridView(List<Friend> friends) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 1.0,
        mainAxisSpacing: 16.0,
        childAspectRatio: 0.85,
      ),
      itemCount: friends.length,
      itemBuilder: (context, index) {
        return _buildFriendCard(context, friends[index]);
      },
    );
  }

  Widget _buildToggleButtons(int selectedViewIndex, WidgetRef ref) {
    return CupertinoSegmentedControl<int>(
      borderColor: Colors.transparent, // Border color
      selectedColor: Colors.transparent, // Selected segment color
      // unselectedColor:
      //     Colors.transparent, // Unselected segment color (transparent)
      // pressedColor: Colors.blue.withOpacity(0.5), // Pressed segment color

      children: {
        0: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(Icons.view_list,
              color: selectedViewIndex == 0 ? Colors.blue : Colors.grey),
        ),
        1: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(Icons.grid_view,
              color: selectedViewIndex == 1 ? Colors.blue : Colors.grey),
        ),
      },
      onValueChanged: (value) {
        ref.read(selectedViewIndexProvider.notifier).state = value;
      },
      groupValue: selectedViewIndex,
    );
  }
}

void showToast(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: Colors.red,
    textColor: Colors.white,
  );
}
