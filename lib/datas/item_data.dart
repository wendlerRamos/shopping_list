import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:scoped_model/scoped_model.dart';

class ItemList{
  String productId;
  String name;
  double quantity;
  String priority;
  double maxValue;
  bool status = false;

  ItemList();
/*
  ItemList(DocumentSnapshot document){
    productId = document.documentID;
    name = document.data["name"];
    quantity = document.data["quantity"];
    priority = document.data["priority"];
    maxValue = document.data["maxValue"];
    status = document.data["status"];
  }*/

  ItemList.fromDocument(DocumentSnapshot document){
      productId = document.documentID;
      name = document.data["name"];
      quantity = document.data["quantity"];
      priority = document.data["priority"];
      maxValue = document.data["maxValue"];
      status = document.data["status"];
  }

  String toString(){
    return ("id: ${this.productId}, name: ${this.name}, status: ${this.status}");
  }

  Map<String , dynamic> toMap(){
    return {
      "id": productId,
      "name" : name,
      "priority" : priority,
      "quantity" : quantity,
      "maxValue" : maxValue,
      "status" : status,
    };
  }

  void updateStaus(listCode){
    if(this.status){
      this.status = false;
    }else{
      this.status = true;
    }
    Firestore.instance.collection("shoppingLists").document(listCode).collection('products').document(this.productId).updateData(this.toMap());
  }
}