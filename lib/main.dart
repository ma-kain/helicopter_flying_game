import 'package:flame/flame.dart';
import 'package:flutter/material.dart';

import 'game.dart';

main() async {
  await Flame.util.fullScreen();
  await Flame.util.setLandscapeLeftOnly();
  runApp(MyGameApp());
}


class MyGameApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flying Helicopter',
      theme: new ThemeData(
        primarySwatch: Colors.red,
      ),
      home: new GameHomePage(),
    );
  }
}

class GameHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    final game = GameScreen(screenSize);
    return game.widget;
  }
}


