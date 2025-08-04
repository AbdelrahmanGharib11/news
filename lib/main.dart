import 'package:flutter/material.dart';
import 'package:news/screens/homescreen.dart';
import 'package:news/screens/searchscreen.dart';
import 'package:news/theme/apptheme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
      theme: AppTheme.lighttheme,
      routes: {'search': (_) => SearchScreen()},
    );
  }
}
