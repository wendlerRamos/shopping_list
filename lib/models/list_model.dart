import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shopping_list/datas/item_data.dart';

class ListModel extends Model {
  List<ItemList> products = [];
  bool isLoading = false;
  String listCode = "lista";

  ListModel(this.listCode) {
    _loadItens();
  }

  @Deprecated("")
  static ListModel of(BuildContext context) =>
      ScopedModel.of<ListModel>(context);

  void addProductToList(ItemList item) {
    products.add(item);
    Firestore.instance
        .collection("shoppingLists")
        .document(listCode)
        .collection('products')
        .add(item.toMap())
        .then((doc) {
      //item.userId = doc.documentID;
    });
    notifyListeners();
  }

  @Deprecated("")
  void removeItem(ItemList itemList) {
    Firestore.instance
        .collection("shoppingLists")
        .document(listCode)
        .collection('products')
        .document(itemList.productId)
        .delete();
    products.remove(itemList);
    notifyListeners();
  }

  @Deprecated("")
  static void removeItem2(ItemList itemList, listCode) async {
    Firestore.instance
        .collection("shoppingLists")
        .document(listCode)
        .collection('products')
        .document(itemList.productId)
        .delete();
  }

  @Deprecated("")
  void setProductStatus(ItemList itemList) {
    if (itemList.status) {
      itemList.status = false;
    } else {
      itemList.status = true;
    }
    Firestore.instance
        .collection("shoppingLists")
        .document(listCode)
        .collection('products')
        .document(itemList.productId)
        .updateData(itemList.toMap());
    notifyListeners();
  }

  @Deprecated("")
  void _loadItens() async {
    isLoading = true;
    QuerySnapshot query = await Firestore.instance
        .collection("shoppingLists")
        .document(listCode)
        .collection('products')
        .orderBy('status')
        .getDocuments();

    products =
        query.documents.map((doc) => ItemList.fromDocument(doc)).toList();
    isLoading = false;
    notifyListeners();
  }

  void updateList() {
    notifyListeners();
  }

  void removeList() {
    Firestore.instance.collection("shoppingLists").document(listCode).delete();
    notifyListeners();
  }

  @Deprecated("")
  static Future<bool> checkIfListCodeExists(String searchCode) async {
    bool exist;
    try {
      await Firestore.instance
          .collection("shoppingLists")
          .document(searchCode)
          .get()
          .then((onValue) {
        if (onValue.exists) {
          exist = true;
        } else {
          exist = false;
        }
      });
      return exist;
    } catch (e) {
      return false;
    }
  }

  @Deprecated("")
  static Future<int> checkIfListCodeNotExists(String searchCode) async {
    int exist;
    try {
      await Firestore.instance
          .collection("shoppingLists")
          .document(searchCode)
          .get()
          .then((onValue) {
        if (onValue.exists) {
          exist = 1; // Exists
        } else {
          exist = 0; //Do not exists
        }
      });
      return exist;
    } catch (e) {
      return 503; //Database connection failure
    }
  }

}
