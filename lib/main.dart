import 'package:flutter/material.dart';
import 'package:untitled21/projects.dart';
import 'package:untitled21/user.dart';
import 'package:untitled21/user.dart';

import 'contact_us.dart';
import 'home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {"/home":(ctx)=>HomePage(),
              "/prodacts":(ctx)=>ProductsScreen(),
              "/user":(ctx)=>LoginScreen(),
              "/ContactUs":(ctx)=>ContactUsScreen(),
      },
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: LoginScreen(),
        // This is the theme of your application.// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
