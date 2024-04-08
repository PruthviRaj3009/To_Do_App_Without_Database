import 'package:flutter/material.dart';
import 'package:full_to_do_app_myself/ToDoApp.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ToDoApp(
          child: Row(),
        ));
  }
}
