import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shopping_list/application/shopping_list/entrypoint/shopping_list_controller.dart';

class ShoppingListTile extends StatelessWidget {
  final shoppingListController = Modular.get<FindShoppingListByCodeController>();
  final String _listName;
  final int _index;

  ShoppingListTile(this._listName, this._index);

  @override
  Widget build(BuildContext context) {
    int _indexPlusOne = _index + 1;
    return Container(
      child: RaisedButton(
        padding: EdgeInsets.only(top: 8.0, bottom: 8.0, right: 10.0, left: 10.0),
        color: (_index % 2) == 0 ? Colors.white : Color.fromARGB(255, 0, 38, 66),
        onPressed: () async {
          final result = await shoppingListController.findByCode(_listName);
          (result.isRight())
              ? notifySearchStatus(true, context)
              : notifySearchStatus(false, context);
        },
        child: Row(
          children: <Widget>[
            Text(
              _listName,
              style: TextStyle(
                color: setColorByIndex(),
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                '#$_indexPlusOne',
                style: TextStyle(
                  color: setColorByIndex(),
                  fontSize: 20.0,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.end,
              ),
            )
          ],
        ),
      ),
    );
  }

  void notifySearchStatus(bool isListFounded, BuildContext context) {
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

  Color setColorByIndex() => (_index % 2) != 0 ? Colors.white : Color.fromARGB(255, 0, 38, 66);
}
