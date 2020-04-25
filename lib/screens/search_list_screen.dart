import 'package:flutter/material.dart';
import 'package:shopping_list/widgets/form_search.dart';

class SearchListScreen extends StatefulWidget {
  @override
  _SearchListScreenState createState() => _SearchListScreenState();
}

class _SearchListScreenState extends State<SearchListScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
        //color: Colors.red,
        child: Column(
      children: <Widget>[
        Card(
            child: Padding(
          padding: EdgeInsets.only(
            bottom: 5.0,
            left: 10.0,
            right: 10.0,
            top: 10.0,
          ),
          child: Column(
            children: <Widget>[
              Text(
                'Buscar Lista',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0,
                  color: Color.fromARGB(255, 0, 38, 66),
                ),
                textAlign: TextAlign.center,
              ),
              Expanded(child: FormSearchList(), flex: 1,)
              
            ],
          ),
        )),
        Card(
          child: Text(''),
        ),
      ],
    ));
  }
}
