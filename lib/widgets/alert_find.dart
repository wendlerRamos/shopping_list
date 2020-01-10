import 'package:flutter/material.dart';
import 'package:shopping_list/widgets/form_search.dart';

alertSearchList(BuildContext context) {
   Widget cancelaButton = FlatButton(
     color: Colors.red,
    child: Text("Cancelar"),
    onPressed:  () {
      Navigator.pop(context);
      Navigator.pop(context);
    },
  );
  Widget continuaButton = FlatButton(
    color: Color.fromARGB(255, 0, 38, 66),
    child: Text("Buscar"),
    onPressed:  null
  );
  //configura o AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("BUSCAR LISTA", style: TextStyle(color: Color.fromARGB(255, 0, 38, 66)),),
    backgroundColor: Colors.orange[50],
    content: FormSearchList(),
    actions: [
      cancelaButton,
      //continuaButton,
    ],
  );
  //exibe o diálogo
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}