import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shopping_list/screens/home.dart';
import 'models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  
  Widget build(BuildContext context) {
      return ScopedModel<UserModel>(
        model: UserModel(),
        child: MaterialApp(
          title: 'Shopping List',
          theme: ThemeData(
              primarySwatch: Colors.teal,
              primaryColor: Colors.indigo,

              //textColor: Colors.indigo[50],
          ),
          debugShowCheckedModeBanner: true,
          home: Home(),
        ),
      );
    }
    
/*
    Widget build(BuildContext context) {
      return  MaterialApp(
          title: 'Shopping List',
          theme: ThemeData(
              primarySwatch: Colors.teal,
              primaryColor: Colors.indigo,

              //textColor: Colors.indigo[50],
          ),
          debugShowCheckedModeBanner: true,
          home: Home(),
        );
    }
    */
}