import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shopping_list/application/shopping_list/entrypoint/shopping_list_controller.dart';
import 'package:shopping_list/domain/shopping_list/model/shopping_list.dart';
import 'package:shopping_list/presenter/shopping_list/widget/form_search.dart';
import 'package:shopping_list/presenter/shopping_list/widget/shopping_list_tile.dart';
import 'package:shopping_list/presenter/util/controller/ColorManager.dart';

class SearchListScreen extends StatefulWidget {
  @override
  _SearchListScreenState createState() => _SearchListScreenState();
}

class _SearchListScreenState extends State<SearchListScreen> {
  final findLastShoppingListsController = Modular.get<FindLastShoppingListsController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Card(
            child: Padding(
              padding: EdgeInsets.only(bottom: 5.0, left: 10.0, right: 10.0, top: 10.0),
              child: Column(
                children: <Widget>[
                  Text(
                    'Buscar Lista',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0,
                      color: ColorManager.getBlueColor(),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  FormSearchList(),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
            child: Text(
              'Ou escolha uma do seu histórico',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25.0,
                color: ColorManager.getBlueColor(),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 1,
            child: FutureBuilder<List<ShoppingList>>(
              future: findLastShoppingListsController.find(),
              builder: (context, AsyncSnapshot<List<ShoppingList>> snapshot) {
                if (snapshot.hasData) {
                  return buildListOfCodes(snapshot.data);
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  StatelessWidget buildListOfCodes(List<ShoppingList> shoppingLists) {
    return (shoppingLists.length == 0)
        ? NoneListOnHistoric()
        : ListView.builder(
            itemCount: shoppingLists.length,
            itemBuilder: (BuildContext context, int index) {
              return ShoppingListTile(
                shoppingLists[index].code,
                index,
              );
            },
          );
  }
}

class NoneListOnHistoric extends StatelessWidget {
  const NoneListOnHistoric({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Icon(
            Icons.format_list_bulleted,
            color: ColorManager.getBlueColor(),
            size: 50.0,
          ),
          Text(
            'Nenhuma lista no seu histórico',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
              color: ColorManager.getBlueColor(),
            ),
          ),
        ],
      ),
    );
  }
}
