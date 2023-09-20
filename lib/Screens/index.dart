import 'package:ahadu/Models/algo.dart';
import 'package:flutter/material.dart';

class Index extends StatelessWidget {
  const Index({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff39B4BF),
      body: ListView.builder(
        addAutomaticKeepAlives: false,
        cacheExtent: 100,
        physics: BouncingScrollPhysics(),
        itemBuilder: (_, item) => Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
          child: Material(
            borderRadius: BorderRadius.circular(5),
            color: Color(0xff432147),
            child: ListTile(
              leading: Text(
                "${item + 1}",
                style: TextStyle(fontSize: 35, color: Colors.white),
              ),
              trailing: Text(
                convertToGeez("${item + 1}"),
                style: TextStyle(fontSize: 35, color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
