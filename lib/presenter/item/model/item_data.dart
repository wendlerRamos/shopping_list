import 'package:cloud_firestore/cloud_firestore.dart';

class ItemList {
  String productId;
  String name;
  double quantity;
  String priority;
  double maxValue;
  bool status = false;

  ItemList();

  ItemList.fromDocument(DocumentSnapshot document) {
    productId = document.documentID;
    name = document.data["name"];
    quantity = document.data["quantity"];
    priority = document.data["priority"];
    maxValue = document.data["maxValue"];
    status = document.data["status"];
  }

  String toString() {
    return ("id: ${this.productId}, name: ${this.name}, status: ${this.status}");
  }

  Map<String, dynamic> toMap() {
    return {
      "id": productId,
      "name": name,
      "priority": priority,
      "quantity": quantity,
      "maxValue": maxValue,
      "status": status,
    };
  }
}
