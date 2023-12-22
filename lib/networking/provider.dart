import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_final/networking/model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

final transactionProvider = StreamProvider<List<TransactionModel>>((ref) {
  // Your logic to create a stream of friends from Firebase or another source
  final friendsCollection =
      FirebaseFirestore.instance.collection('transactions');
  return friendsCollection.snapshots().map((snapshot) {
    return snapshot.docs
        .map((doc) => TransactionModel(
              name: doc['Name'],
              date: doc['Date'],
              price: doc['Price'],
              icon: doc['Icon'],
            ))
        .toList();
  });
});
