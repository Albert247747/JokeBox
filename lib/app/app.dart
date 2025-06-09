import 'package:flutter/material.dart';

import 'package:todo/app/home_page/home_page.dart';





class App extends StatelessWidget{

  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xff1F1D2B)
      ),
      home:JokeHomePage(),
    );
  }
}