import 'package:flutter/material.dart';
import 'package:loja_virtual/screens/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Loja Virtual Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Color.fromARGB(255, 11, 144, 253),
      ),
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
