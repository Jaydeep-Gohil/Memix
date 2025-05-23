import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memix/screens/meme_home_page.dart';

void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MemeHomePage(),

    );
  }
}