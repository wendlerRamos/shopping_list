import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shopping_list/application/item/entrypoint/item_controller.dart';
import 'package:shopping_list/presenter/core/controller/shopping_list_store.dart';
import 'package:shopping_list/presenter/shopping_list/controller/empty_code_state_option.dart';
import 'package:shopping_list/presenter/shopping_list/controller/empty_data_state_option.dart';
import 'package:shopping_list/presenter/shopping_list/controller/error_state_option.dart';
import 'package:shopping_list/presenter/shopping_list/controller/list_items_state_option.dart';
import 'package:shopping_list/presenter/shopping_list/controller/state_options.dart';
import 'package:shopping_list/presenter/shopping_list/controller/waiting_data_state_option.dart';

class ItemsList extends StatefulWidget {
  @override
  _ItemsListState createState() => _ItemsListState();
}

class _ItemsListState extends State<ItemsList> {
  final List<StateOptions> stateOptions = [
    EmptyCodeStateOption(),
    EmptyDataStateOption(),
    ErrorStateOption(),
    ListItemsStateOption(),
    WaitingDataStateOption(),
  ];

  final findItemsByShoppingListCode =
      Modular.get<FindItemsByShoppingListCodeController>();

  @override
  Widget build(BuildContext context) {
    String _listCode = ShoppingListStore().getCurrentList();
    return Expanded(
      child: Card(
        margin: EdgeInsets.all(1.0),
        child: Padding(
          padding: EdgeInsets.all(4.0),
          child: StreamBuilder(
            stream: findItemsByShoppingListCode.find(_listCode),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              return stateOptions
                  .firstWhere((option) => option.verify(snapshot, _listCode))
                  .execute(snapshot.data);
            },
          ),
        ),
      ),
    );
  }
}
