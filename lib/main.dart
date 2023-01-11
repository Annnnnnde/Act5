import 'package:benting_activity5/homepage.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.amber,
    ),
    title: "Benting - Activity 5",
    home: const HomePage(),
  )
  );
}