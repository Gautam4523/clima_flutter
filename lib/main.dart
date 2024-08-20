import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'loading_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: LoadingPage(),
    );
  }
}