import 'package:flutter/material.dart';
import 'package:shopping_list/datas/list_code_store.dart';
import 'package:shopping_list/models/list_model.dart';

class ShoppingListTile extends StatelessWidget {
  final String _listName;
  final int _index;

  const ShoppingListTile(this._listName, this._index);

  @override
  Widget build(BuildContext context) {
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
    int _indexPlusOne = _index + 1;
    return Container(
      child: RaisedButton(
          padding:
              EdgeInsets.only(top: 8.0, bottom: 8.0, right: 10.0, left: 10.0),
          color:
              (_index % 2) == 0 ? Colors.white : Color.fromARGB(255, 0, 38, 66),
          onPressed: () {
            Future<bool> result = ListModel.checkIfListCodeExists(_listName);
            result.then((value) async {
              if (value) {
                ListCode().setCurrentList(_listName);
                notificateSearchStatus(true);
              } else {
                notificateSearchStatus(false);
              }
            });
          },
          child: Row(
            children: <Widget>[
              Text(
                _listName,
                style: TextStyle(
                    color: (_index % 2) != 0
                        ? Colors.white
                        : Color.fromARGB(255, 0, 38, 66),
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  '#$_indexPlusOne',
                  style: TextStyle(
                      color: (_index % 2) != 0
                          ? Colors.white
                          : Color.fromARGB(255, 0, 38, 66),
                      fontSize: 20.0,
                      fontStyle: FontStyle.italic),
                  textAlign: TextAlign.end,
                ),
              )
            ],
          )),
    );
  }
}
