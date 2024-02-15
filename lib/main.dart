import 'package:clima1_oop2/screens/city_screen.dart';
import 'package:clima1_oop2/screens/location_screen.dart';
import 'package:flutter/material.dart';
import 'package:clima1_oop2/screens/loading_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: LoadingScreen(),
    );
  }
}
