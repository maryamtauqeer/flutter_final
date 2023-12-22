import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_final/networking/model.dart';
import 'package:flutter_final/networking/ui_screen.dart';
import 'package:flutter_final/networking/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DashboardScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.exit_to_app, color: Colors.white),
            onPressed: () async {},
          ),
        ],
      ),
      body: _buildDashboardScreen(ref),
    );
  }

  Widget _buildDashboardScreen(WidgetRef ref) {
    AsyncValue<List<TransactionModel>> transactionsList =
        ref.watch(transactionProvider);

    return Column(
      children: [
        // Day and Date Row
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Monday',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    '17 Nov',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              Text(
                '\$2983',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: transactionsList.when(
            loading: () => Center(child: CircularProgressIndicator()),
            error: (error, stack) => Text('Error: $error'),
            data: (transaction) {
              print("Transactions: $transaction");
              return _buildListView(transaction);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCard(BuildContext context, TransactionModel transaction) {
    String formattedPrice = transaction.price.startsWith('-')
        ? '-\$${transaction.price.substring(1)}'
        : '+\$${transaction.price.substring(1)}';

    bool isToday = isTodayDate(transaction.date);
    String subtitleText = isToday
        ? 'Today'
        : (isYesterdayDate(transaction.date) ? 'Yesterday' : transaction.date);

    return ListTile(
      leading: CircleAvatar(
        radius: 30.0,
        backgroundImage: NetworkImage(transaction.icon),
      ),
      title: Text(transaction.name),
      subtitle: Text(
        subtitleText,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: Text(
        formattedPrice,
        style: TextStyle(fontSize: 20, color: Colors.red),
      ),
      onTap: () {},
    );
  }

  Widget _buildListView(List<TransactionModel> transactions) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      margin: EdgeInsets.all(16),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Transactions',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                return _buildCard(context, transactions[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

// taken from stackoverflow and modified
bool isTodayDate(String date) {
  DateTime currentDate = DateTime.now();
  DateTime transactionDate = parseCustomDate(date);

  return currentDate.year == transactionDate.year &&
      currentDate.month == transactionDate.month &&
      currentDate.day == transactionDate.day;
}

bool isYesterdayDate(String date) {
  DateTime yesterdayDate = DateTime.now().subtract(Duration(days: 1));
  DateTime transactionDate = parseCustomDate(date);

  return yesterdayDate.year == transactionDate.year &&
      yesterdayDate.month == transactionDate.month &&
      yesterdayDate.day == transactionDate.day;
}

DateTime parseCustomDate(String date) {
  final List<String> months = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];

  List<String> parts = date.split(" ");
  if (parts.length == 3) {
    int day = int.tryParse(parts[0]) ?? 0;
    int monthIndex = months.indexOf(parts[1]);
    int year = int.tryParse(parts[2]) ?? 0;

    if (day != 0 && monthIndex != -1 && year != 0) {
      return DateTime(year, monthIndex + 1, day);
    }
  }

  return DateTime.now();
}
