import 'package:flutter/material.dart';
import 'package:flutter_application_1/page.dart';
import 'package:flutter_application_1/widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Explore Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(), // This is the entry point to your app
      routes: {
        '/widgets': (context) => const WidgetsPage(),
      },
    );
  }
}
