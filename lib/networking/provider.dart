import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_final/networking/album_model.dart';
import 'package:flutter_final/networking/auth_service.dart';
import 'package:flutter_final/networking/model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

final authProvider = StateProvider<User?>((ref) {
  return null;
});

final isPasswordVisibleProvider = StateProvider<bool>((ref) {
  return false;
});

final authServiceProvider = Provider<AuthService>((ref) => AuthService());

final emailControllerProvider = Provider<TextEditingController>((ref) =>
    TextEditingController()); //credentials widget recreation mai clear na hon
final passwordControllerProvider =
    Provider<TextEditingController>((ref) => TextEditingController());
final confirmPasswordControllerProvider =
    Provider<TextEditingController>((ref) {
  return TextEditingController();
});

final friendsProvider = StreamProvider<List<Friend>>((ref) {
  // Your logic to create a stream of friends from Firebase or another source
  final friendsCollection = FirebaseFirestore.instance.collection('friends');
  return friendsCollection.snapshots().map((snapshot) {
    return snapshot.docs
        .map((doc) => Friend(
              name: doc['name'],
              email: doc['email'],
              phone: doc['phone'],
              image: doc['image'],
            ))
        .toList();
  });
});

// final isListViewProvider = StateProvider<bool>((ref) {
//   return false; // Set the initial value based on your default view
// });

final currentIndexProvider = StateProvider<int>((ref) {
  return 0; // Initial index, set to the default tab you want to be selected.
});

final apiDataProvider = FutureProvider<List<Album>>((ref) async {
  final response =
      await http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums'));
  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body);
    return data.map((json) => Album.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load data');
  }
});

final selectedViewIndexProvider = StateProvider<int>((ref) => 0);
