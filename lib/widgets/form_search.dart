import 'package:flutter/material.dart';
import 'package:shopping_list/datas/list_code_store.dart';
import 'package:shopping_list/models/list_model.dart';

class FormSearchList extends StatefulWidget {
  @override
  _FormSearchListState createState() => _FormSearchListState();
}

class _FormSearchListState extends State<FormSearchList> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final _searchListCode = TextEditingController();
    if (_isLoading) {
      return Column(
        children: <Widget>[
          SizedBox(
            height: 50.0,
          ),
          Center(
            child: CircularProgressIndicator(),
          )
        ],
      );
    }

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              controller: _searchListCode,
              autofocus: false,
              decoration: const InputDecoration(
                icon: Icon(Icons.search),
                hintText: 'Informe o código da lista',
                labelText: 'Código *',
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Informe o código da lista';
                }
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: RaisedButton(
                color: Color.fromARGB(255, 236, 78, 32),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    setState(() {
                      _isLoading = true;
                    });
                    Future<bool> result =
                        ListModel.checkIfListCodeExists(_searchListCode.text);
                    result.then((value) async {
                      if (value) {
                        ListCode().setCurrentList(_searchListCode.text);
                        notificateSearchStatus(true);
                      } else {
                        notificateSearchStatus(false);
                      }
                      setState(() {
                        _isLoading = false;
                      });
                    });
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.search,
                      color: Colors.orange[50],
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10.0),
                    ),
                    Text(
                      'Buscar',
                      style: TextStyle(color: Colors.orange[50], fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10.0),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void notificateSearchStatus(bool isListFounded) {
    if (isListFounded) {
      final snackBar = SnackBar(
        content: Text(
          'Lista selecionada com sucesso !',
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.green[900],
      );
      Scaffold.of(context).showSnackBar(snackBar);
    } else {
      final snackBar = SnackBar(
        content: Text(
          'Código de lista não encontrado !',
          textAlign: TextAlign.center,
        ),
        backgroundColor: Color.fromARGB(255, 236, 78, 32),
      );
      Scaffold.of(context).showSnackBar(snackBar);
    }
  }
}
