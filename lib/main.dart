import 'package:flutter/material.dart';
import 'package:ordering/dashboard.dart';
import 'package:ordering/ordering.dart';

void main() {
  runApp(
    const myApp(),
  );
}

class myApp extends StatelessWidget {
  const myApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My App',
      home: Dashboard(),
    );
  }
}
