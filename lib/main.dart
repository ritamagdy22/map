import 'package:flutter/material.dart';
import 'package:map/Location/HomeScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {HommeScreen.routename: (context) => HommeScreen()},
      initialRoute: HommeScreen.routename,
    );
  }
}
