import 'package:flutter/material.dart';
import 'Routes/Routes.dart' as router;
import 'Routes/RouteConstants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: router.generateRoute,
      initialRoute: HomeRoute,
    );
  }
}
