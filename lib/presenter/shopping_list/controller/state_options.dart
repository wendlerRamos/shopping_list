import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

abstract class StateOptions {
  bool verify(AsyncSnapshot<QuerySnapshot> snapshot, String listCode);

  Widget execute(QuerySnapshot snapshot);
}
