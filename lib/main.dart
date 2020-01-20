import 'package:flutter/material.dart';
import 'package:shopping_list/datas/list_code_store.dart';
import 'package:shopping_list/screens/home.dart';

void main() => runApp(Main());

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  ListCode _listCode;
  @override
  Widget build(BuildContext context) {
    this._listCode = ListCode();
    print(_listCode);
//    this._listCode.setCurrentList('teste');
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