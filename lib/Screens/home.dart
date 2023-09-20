import 'dart:async';
import 'dart:io';

import 'package:ahadu/Routes/RouteConstants.dart';
import 'package:ahadu/Screens/gameView.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Home extends StatefulWidget {
  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  Future<bool> checkinternet() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } on SocketException catch (_) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: const Color(0xff39B4BF),
      body: Center(
        child: Wrap(
          runSpacing: 5,
          spacing: 20,
          children: [
            Container(
              width: 140,
              height: 140,
              child: Material(
                borderRadius: BorderRadius.circular(30),
                elevation: 4,
                color: Color(0xff432147),
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, GameViewRoute);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      const Text(
                        "፩ + ፪ = ?",
                        style:
                            const TextStyle(color: Colors.white, fontSize: 30),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        "Play",
                        style:
                            const TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: 140,
              height: 140,
              child: Material(
                borderRadius: BorderRadius.circular(30),
                elevation: 4,
                color: Color(0xff432147),
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, IndexRoute);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      FaIcon(
                        FontAwesomeIcons.infinity,
                        color: Colors.white,
                        size: 50,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Geez Numbers",
                        style:
                            const TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
