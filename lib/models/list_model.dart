import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopping_list/datas/item_data.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';

class ListModel extends Model{
  List<ItemList> products = [];
  bool isLoading = false;
  String listCode = "lista";


  ListModel(this.listCode) {
    _loadItens();
  }


  static  ListModel of(BuildContext context) => ScopedModel.of<ListModel>(context);

  void addProductToList(ItemList item){
    products.add(item);
    Firestore.instance.collection("shoppingLists").document(listCode).collection('products').add(item.toMap()).then((doc){
      //item.userId = doc.documentID;
    });
    notifyListeners();
  }

  void removeItem(ItemList itemList){
    Firestore.instance.collection("shoppingLists").document(listCode).collection('products').document(itemList.productId).delete();
    products.remove(itemList);
    notifyListeners();
  }

  static void removeItem2(ItemList itemList, listCode){
    Firestore.instance.collection("shoppingLists").document(listCode).collection('products').document(itemList.productId).delete();
  }

  void setProductStatus(ItemList itemList){
    if(itemList.status){
      itemList.status = false;
    }else{
      itemList.status = true;
    }
    Firestore.instance.collection("shoppingLists").document(listCode).collection('products').document(itemList.productId).updateData(itemList.toMap());
    notifyListeners();
  }

  void _loadItens() async {
    isLoading = true;
    QuerySnapshot query = await Firestore.instance.collection("shoppingLists").document(listCode).collection('products')
        .getDocuments();

    products = query.documents.map((doc) => ItemList.fromDocument(doc)).toList();
    isLoading = false;
    notifyListeners();
  }



  void updateList(){
    notifyListeners();
  }


  void removeList(){
    Firestore.instance.collection("shoppingLists").document(listCode).delete();
    notifyListeners();
  }

}