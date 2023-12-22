import 'package:flutter/material.dart';
import 'package:flutter_final/firebase_options.dart';
import 'package:flutter_final/networking/dashboard.dart';
import 'package:flutter_final/networking/ui_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ProviderScope(
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple),
      ),
      initialRoute: '/dashboard',
      routes: {
        '/dashboard': (context) => DashboardScreen(),
        '/ui': (context) => UIScreen(),
      },
    );
  }
}
