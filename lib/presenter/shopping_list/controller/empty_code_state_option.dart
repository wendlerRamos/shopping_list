import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:shopping_list/presenter/shopping_list/controller/state_options.dart';
import 'package:shopping_list/presenter/shopping_list/widget/empty_code_banner_widget.dart';

class EmptyCodeStateOption extends StateOptions {
  @override
  Widget execute(QuerySnapshot snapshot) => EmptyCodeBannerWidget();

  @override
  bool verify(AsyncSnapshot<QuerySnapshot> snapshot, String listCode) =>
      listCode == null;
}
