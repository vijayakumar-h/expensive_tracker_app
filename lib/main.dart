import 'package:flutter/material.dart';

void main() {
  runApp(const ExpensiveTrackerApp());
}

class ExpensiveTrackerApp extends StatelessWidget {
  const ExpensiveTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Expensive tracker App"),
      ),
      body: const Center(
        child: Text("Text"),
      ),
    );
  }
}
