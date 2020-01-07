import 'package:flutter/material.dart';
import 'package:shopping_list/widgets/drawer.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text('Home'),
        ),
        drawer: NavigationDrawerWidget(),
        body:  Container(
            color: Color.fromARGB(255, 234, 224, 213),
            alignment: Alignment.center,
            child: Text( 'This is the home screen', style: TextStyle(color: Colors.blue[900]),),
        ),
    );
  }
}