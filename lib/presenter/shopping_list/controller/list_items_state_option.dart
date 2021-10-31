import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_list/presenter/item/model/item_data.dart';
import 'package:shopping_list/presenter/item/widget/item_tile.dart';
import 'package:shopping_list/presenter/shopping_list/controller/state_options.dart';

class ListItemsStateOption extends StateOptions {
  @override
  Widget execute(QuerySnapshot snapshot) {
    return RefreshIndicator(
      child: ListView(
        physics: BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: snapshot.documents.map((DocumentSnapshot document) {
          ItemList _itemList = ItemList.fromDocument(document);
          return ItemTile(
            itemList: _itemList,
          );
        }).toList(),
      ),
      //TODO("how to do that ?")
      onRefresh: _refresh,
    );
  }

  Future<void> _refresh() async {}

  @override
  bool verify(AsyncSnapshot<QuerySnapshot> snapshot, String listCode) =>
      listCode != null &&
      snapshot.hasData &&
      !snapshot.hasError &&
      snapshot.data.documents.isNotEmpty;
}
