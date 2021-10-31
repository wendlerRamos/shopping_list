import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_list/presenter/shopping_list/controller/state_options.dart';

class WaitingDataStateOption extends StateOptions {
  @override
  Widget execute(QuerySnapshot snapshot) =>
      Center(child: CircularProgressIndicator());

  @override
  bool verify(AsyncSnapshot<QuerySnapshot> snapshot, String listCode) =>
      listCode.isNotEmpty && !snapshot.hasData;
}
