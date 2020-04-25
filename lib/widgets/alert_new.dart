import 'package:flutter/material.dart';
import 'package:shopping_list/models/list_model.dart';

@deprecated
alertNewList(BuildContext context) {
   Widget cancelaButton = FlatButton(
     color: Colors.red,
    child: Text("Cancelar"),
    onPressed:  () {
      Navigator.of(context).pop();
      
    },
  );
  Widget continuaButton = FlatButton(
    color: Color.fromARGB(255, 0, 38, 66),
    child: Text("Criar"),
    onPressed: (){
      ListModel.createList();
      Navigator.pop(context);
    },
  );
  //configura o AlertDialog
  AlertDialog alert = AlertDialog(
    
    title: Text("NOVA LISTA", style: TextStyle(color: Color.fromARGB(255, 0, 38, 66)),),
    backgroundColor: Colors.orange[50],
    content: Text("Deseja criar uma nova lista de compras ?"),
    actions: [
      cancelaButton,
      continuaButton,
      
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