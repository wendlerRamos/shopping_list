import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping List',
      theme: ThemeData(
          primarySwatch: Colors.teal,
          primaryColor: Colors.indigo
      ),
      debugShowCheckedModeBanner: true,
      home: Scaffold(

        appBar: AppBar(
            backgroundColor: Colors.indigo[900],
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[

                Icon(Icons.shopping_cart),
                Padding(padding: EdgeInsets.only(left: 10.0),),
                Text("Shopping List"),
              ],
            )
        ),
        body: Container(
          //child: Image.asset('images/logo_appbar.png'),
          alignment: Alignment.center,
          child: Text('Hello World'),
        ),
      ),
    );
  }
}