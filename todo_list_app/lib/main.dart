import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_list_app/screens/home.dart';

// FINAL APP 
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );
    return  const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "TO-DO APP",
      home: Home(),
    );
  }
}
