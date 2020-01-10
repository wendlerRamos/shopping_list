import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopping_list/screens/home.dart';

void main() => runApp(Main());

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {

  @override
  void initState() {
    
    Firestore.instance
        .collection("teste")
        .document("teste")
        .setData({"teste": "teste"});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return
      MaterialApp(
        title: 'Shopping List',
        theme: ThemeData(
            primaryColor:  Colors.black,
        ),
        debugShowCheckedModeBanner: true,
        home:  HomeScreen(),
    );
  }
}