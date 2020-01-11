import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopping_list/widgets/alert_new.dart';
import 'package:shopping_list/widgets/drawer.dart';
import 'package:shopping_list/widgets/form_new_item.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var _scaffoldState = GlobalKey<ScaffoldState>();
    return Scaffold(
        key: _scaffoldState,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text('Home'),
        ),
        drawer: NavigationDrawerWidget(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color.fromARGB(255, 236, 78, 32),
          child: Icon(
            Icons.add,
            size: 50.0,
          ),
          onPressed: () {
            //testFirebase();
            alertNewList(context);
          },
        ),
        body: SingleChildScrollView(
          padding:
              EdgeInsets.only(top: 5.0, bottom: 2.0, left: 5.0, right: 5.0),
          scrollDirection: Axis.vertical,
          child: Column(
            children: <Widget>[
              Card(
                borderOnForeground: true,
                child: Padding(
                  padding: EdgeInsets.all(4.0),
                  child: FormRegister(),
                )
              ),
            ],
          ),
        ));
  }

  void testFirebase() {
    try {
      Firestore.instance
          .collection('books')
          .document()
          .setData({'title': 'title', 'author': 'author'});
      print('SUCESSO !');
    } catch (e) {
      print('FALHA !');
    }
  }
}
