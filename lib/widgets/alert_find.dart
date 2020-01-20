import 'package:flutter/material.dart';
import 'package:shopping_list/widgets/form_search.dart';

class AlertSeachList extends StatefulWidget {
  @override
  _AlertSeachListState createState() => _AlertSeachListState();
}

class _AlertSeachListState extends State<AlertSeachList> {
  @override
  Widget build(BuildContext context) {
    Widget cancelaButton = FlatButton(
     color: Colors.red,
      child: Text("Cancelar"),
      onPressed:  () {
        Navigator.pop(context);
      },
    );

    
    return AlertDialog(
      title: Text("BUSCAR LISTA", style: TextStyle(color: Color.fromARGB(255, 0, 38, 66)),),
      backgroundColor: Colors.orange[50],
      content: FormSearchList(),
      actions: [
        cancelaButton,
        //continuaButton,
      ],
    );
  }
}