import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});
  static const routeName = "main_app";
  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
      body:  Center(child: Text("main app")),
    );
  }
}
