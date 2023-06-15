import 'package:final_bim494_project/pages/doctor_page.dart';
import 'package:final_bim494_project/pages/medicine_page.dart';
import 'package:final_bim494_project/pages/medicine_suggestion.dart';
import 'package:final_bim494_project/pages/profile_page.dart';
import 'package:final_bim494_project/pages/welcome_screen.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'global_bloc.dart';

void main() {
  runApp(const MedminderApp());
}

class MedminderApp extends StatefulWidget {
  const MedminderApp({super.key});

  @override
  State<MedminderApp> createState() => _MedminderAppState();
}

class _MedminderAppState extends State<MedminderApp> {
  // This widget is the root of your application.
  GlobalBloc? globalBloc;

  @override
  void initState() {
    globalBloc = GlobalBloc();
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider<GlobalBloc>.value(
      value: globalBloc!,
      child: Sizer(builder: (context, orientation, deviceType) {
        return MaterialApp(
          title: 'BIM494 Mobile Programming Project',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
          ),
          home: WelcomeScreen(),
        );
      }
    ));
  }
}
