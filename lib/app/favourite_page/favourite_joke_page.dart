import 'package:flutter/material.dart';

class FavouriteJokePage extends StatelessWidget {
  const FavouriteJokePage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Избранные шутки',),
        centerTitle: true,
        backgroundColor: Color(0xFFFFFFFF),

      ),
    );
  }
}
