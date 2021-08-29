import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:spaced_trip_scheduler/constants.dart';
import 'package:spaced_trip_scheduler/pages/authentication_page.dart';
import 'package:spaced_trip_scheduler/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: kBackgroundColor,
        primarySwatch: Colors.grey,
        primaryColor: kPrimaryColor,
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.transparent,
          textTheme: TextTheme(
            headline6: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        textTheme: const TextTheme(
          bodyText2: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontFamily: 'SFProText',
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            primary: kPrimaryColor, // This is a custom color variable
          ),
        ),
      ),
      home: const AuthenticationPage(),
    );
  }
}
