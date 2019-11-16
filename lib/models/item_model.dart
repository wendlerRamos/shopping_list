import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopping_list/datas/item_data.dart';
import 'package:shopping_list/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class ListModel extends Model{
  UserModel user;
  List<ItemList> products = [];
  bool isLoading = false;
  String listCode = "lista";


  ListModel(this.user) {
    
    if(user.isLoggedIn()){
      _loadItens();
    }
  }


  static  ListModel of(BuildContext context) => ScopedModel.of<ListModel>(context);

  void addProductToList(ItemList item){
    products.add(item);
    Firestore.instance.collection("users").document(user.firebaseUser.uid).collection("shoppingLists").document(listCode).collection('products').add(item.toMap()).then((doc){
      //item.userId = doc.documentID;
    });
    notifyListeners();
  }

  void removeItem(ItemList itemList){
    Firestore.instance.collection("users").document(user.firebaseUser.uid).collection("shoppingLists").document(listCode).collection('products').document(itemList.productId).delete();
    products.remove(itemList);
    notifyListeners();
  }



  void setProductStatus(ItemList itemList){
    if(itemList.status){
      itemList.status = false;
    }else{
      itemList.status = true;
    }
    Firestore.instance.collection("users").document(user.firebaseUser.uid).collection("shoppingLists").document(listCode).collection('products').document(itemList.productId).updateData(itemList.toMap());
    notifyListeners();
  }

  void _loadItens() async {
    QuerySnapshot query = await Firestore.instance.collection("users").document(user.firebaseUser.uid).collection("shoppingLists").document(listCode).collection('products')
        .getDocuments();

    products = query.documents.map((doc) => ItemList.fromDocument(doc)).toList();
    notifyListeners();
  }



  void updateList(){
    notifyListeners();
  }


  void removeList(){
    Firestore.instance.collection("users").document(user.firebaseUser.uid).collection("shoppingLists").document(listCode).delete();
    notifyListeners();
  }

}