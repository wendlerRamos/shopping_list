import 'package:flutter/material.dart';

void main() => runApp(Main());

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  Widget build(BuildContext context) {
    return
      MaterialApp(
        title: 'Shopping List',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            primaryColor:  Colors.orange[900],
        ),
        debugShowCheckedModeBanner: true,
        home:  Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.orange[900],
            title: Text('Shopping List'),
          ),
          body:  Container(
              alignment: Alignment.center,
              child: Text( 'This is the main', style: TextStyle(color: Colors.blue[900]),),
          ),
      )
    );
  }
}