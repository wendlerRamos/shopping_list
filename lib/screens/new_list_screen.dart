import 'package:flutter/material.dart';
import 'package:shopping_list/datas/list_code_store.dart';
import 'package:shopping_list/models/list_model.dart';

class NewListScreen extends StatefulWidget {
  @override
  _NewListScreenState createState() => _NewListScreenState();
}

class _NewListScreenState extends State<NewListScreen> {

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    Widget _continuaButton = FlatButton(
      color: Color.fromARGB(255, 236, 78, 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.add_circle,
            color: Colors.orange[50],
            size: 20.0,
          ),
          Text(
            '\t\tCriar Lista',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                color: Colors.orange[50]),
          )
        ],
      ),
      onPressed: () async {
        setState(() {
          _isLoading = true;
        });
        String newCodeList = await ListModel.createList();
        if (newCodeList != null) {
          final snackBar = SnackBar(
            content: Text(
              'Lista criada com sucesso !\n Código ' + newCodeList,
              textAlign: TextAlign.center,
            ),
            backgroundColor: Colors.green[900],
          );
          Scaffold.of(context).showSnackBar(snackBar);
        } else {
          final snackBar = SnackBar(
            content: Text(
              'Houve uma falha na criação da lista, tente novamente mais tarde !',
              textAlign: TextAlign.center,
            ),
            backgroundColor: Colors.red[900],
          );
          Scaffold.of(context).showSnackBar(snackBar);
        }
        setState(() {
          _isLoading = false;
        });
      },
    );

    if(_isLoading){
      return Center(
        child: CircularProgressIndicator(

        ),
      );
    }

    return Container(
      child: Card(
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
              'Criar Lista',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30.0,
                color: Color.fromARGB(255, 0, 38, 66),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
                'Cria uma nova lista com um código aleatório, que é usado para acessá-la'),
            SizedBox(
              height: 10.0,
            ),
            _continuaButton
          ],
        ),
      )),
    );
  }
}
