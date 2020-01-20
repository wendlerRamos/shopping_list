import 'package:flutter/material.dart';
import 'package:shopping_list/datas/list_code_store.dart';
import 'package:shopping_list/models/list_model.dart';

class FormSearchList extends StatefulWidget {
  @override
  _FormSearchListState createState() => _FormSearchListState();
}

class _FormSearchListState extends State<FormSearchList> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final _searchListCode = TextEditingController();
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              controller: _searchListCode,
              autofocus: true,
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
                color: Color.fromARGB(255, 0, 38, 66),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    Future<bool> result =
                        ListModel.checkIfListCodeExists(_searchListCode.text);
                    result.then((value) async {
                      if (value) {
                        ListCode().setCurrentList(_searchListCode.text);
                      } else {
                        Navigator.pop(context);
                      }
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
                      style: TextStyle(color: Colors.orange[50]),
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
}
