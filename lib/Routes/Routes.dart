import 'dart:collection';

import 'package:ahadu/Routes/RouteConstants.dart';
import 'package:ahadu/Screens/gameView.dart';
import 'package:ahadu/Screens/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ahadu/Screens/home.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  // var arg = settings.arguments;
  switch (settings.name) {
    case HomeRoute:
      return MaterialPageRoute(builder: (context) => Home());
    case IndexRoute:
      return MaterialPageRoute(builder: (context) => Index());
    case GameViewRoute:
      return MaterialPageRoute(builder: (context) => GameView());
    default:
      return MaterialPageRoute(builder: (context) => Home());
  }
}
