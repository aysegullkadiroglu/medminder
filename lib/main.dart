import 'package:final_bim494_project/pages/profile_page.dart';
import 'package:final_bim494_project/pages/welcome_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MedminderApp());
}

class MedminderApp extends StatelessWidget {
  const MedminderApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BIM494 Mobile Programming Project',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
      ),
      home: ProfilePage(),
    );
  }
}
