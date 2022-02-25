import 'package:flutter/material.dart';
import 'package:flutter_calculator/util/index.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator App',
      theme: ThemeData(),
      home: const CalculatorScreen(),
    );
  }
}
