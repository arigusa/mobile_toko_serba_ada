import 'package:flutter/material.dart';
import 'package:toko_serba_ada/screens/homePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'toko serba ada', home: HomePage());
  }
}
