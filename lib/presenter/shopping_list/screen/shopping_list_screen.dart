
import 'package:flutter/material.dart';
import 'package:shopping_list/presenter/core/controller/shopping_list_store.dart';
import 'package:shopping_list/presenter/shopping_list/widget/empty_code_banner_widget.dart';
import 'package:shopping_list/presenter/shopping_list/widget/form_card.dart';
import 'package:shopping_list/presenter/shopping_list/widget/shopping_list_screen_header.dart';
import 'package:shopping_list/widgets/items_list.dart';

class ShoppingListScreen extends StatefulWidget {
  @override
  _ShoppingListScreenState createState() => _ShoppingListScreenState();
}

class _ShoppingListScreenState extends State<ShoppingListScreen> {
  String _listCode;

  @override
  Widget build(BuildContext context) {
    _listCode = ShoppingListStore().getCurrentList();

    final _formCard =
        (_listCode != null) ? FormCard() : EmptyCodeBannerWidget();

    var _scaffoldState = GlobalKey<ScaffoldState>();
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        key: _scaffoldState,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: ShoppingListScreenHeader(listCode: _listCode),
          bottom: TabBar(
            indicatorColor: Colors.deepOrange,
            labelColor: Colors.deepOrange,
            unselectedLabelColor: Colors.black,
            tabs: [
              Tab(
                text: "Ver Lista",
              ),
              Tab(
                text: "Adicionar Item",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Padding(
              padding:
                  EdgeInsets.only(top: 0.0, bottom: 2.0, left: 5.0, right: 5.0),
              child: Column(
                verticalDirection: VerticalDirection.down,
                children: <Widget>[
                  SizedBox(
                    height: 1.0,
                  ),
                  ItemsList()
                ],
              ),
            ),
            _formCard,
          ],
        ),
      ),
    );
  }
}
