import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class FormAddTile extends StatefulWidget {
  @override
  _FormAddTileState createState() => _FormAddTileState();
}

class _FormAddTileState extends State<FormAddTile> {
  final _formKey = GlobalKey<FormState>();
  final _scafoldKey = GlobalKey<ScaffoldState>();


  final _itemController = TextEditingController();
  final _qtController = TextEditingController();
  final _priorityController = TextEditingController();
  final _maxValueController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      //margin: EdgeInsets.all(2.0),
      padding: EdgeInsets.all(0.0),
      child: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(4.0),
          children: <Widget>[
            Text("This is a test")
          ],
        )
      ),
    );
  }
}
