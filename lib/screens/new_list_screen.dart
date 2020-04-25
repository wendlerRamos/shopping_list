import 'package:flutter/material.dart';

class NewListScreen extends StatefulWidget {
  @override
  _NewListScreenState createState() => _NewListScreenState();
}

class _NewListScreenState extends State<NewListScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: Center(
        child: Column(
          children: <Widget>[
            Text("Tela de criar lista"),
            FlatButton(
              onPressed: () {
                  
              }, 
              child: Icon(Icons.change_history))
          ],
        ),
      ),
    );
  }
}
