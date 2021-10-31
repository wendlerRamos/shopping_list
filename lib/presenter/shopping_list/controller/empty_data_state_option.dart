import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_list/presenter/shopping_list/controller/state_options.dart';
import 'package:shopping_list/presenter/util/controller/ColorManager.dart';

class EmptyDataStateOption extends StateOptions {
  @override
  Widget execute(QuerySnapshot snapshot) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.remove_shopping_cart,
            size: 100.0,
            color: ColorManager.getBlueColor(),
          ),
          Text(
            "A lista está vazia!",
            style: TextStyle(
              color: ColorManager.getBlueColor(),
              fontSize: 30.0,
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool verify(AsyncSnapshot<QuerySnapshot> snapshot, String listCode) =>
      listCode != null && snapshot.hasData && !snapshot.hasError && snapshot.data.documents.isEmpty;
}
