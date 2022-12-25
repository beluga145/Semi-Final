import 'package:flutter/material.dart';
import 'MyHomePage.dart';

void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData.dark(),
    home: const HomePage(),
  ));
}