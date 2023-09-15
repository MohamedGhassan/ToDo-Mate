import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:noteapp_php/app/notes/add.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/auth/login.dart';
import 'app/auth/signup.dart';
import 'app/auth/success.dart';
import 'app/home.dart';
import 'app/notes/edit.dart';

late SharedPreferences sharedPref;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPref = await SharedPreferences.getInstance();
  runApp(const MyApp());
  }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Course PHP Rest API',
            // theme: Themes.light,
            // darkTheme: Themes.dark,
            initialRoute: sharedPref.getString('id') == null ? "login" : "home",
            routes: {
              'login': (context) => LoginScreen(),
              'signup': (context) => SignUpScreen(),
              'home': (context) => HomeScreen(),
              'success': (context) => Success(),
              'addnotes': (context) => AddNotes(),
              'editnotes': (context) => EditNotes(),
            },
            home: LoginScreen());
      },
    );
  }
}
