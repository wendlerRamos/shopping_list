import 'package:flutter_modular/flutter_modular.dart';
import 'package:shopping_list/domain/shopping_list/gateway/input/find_current_shopping_list_input.dart';
import 'package:shopping_list/domain/shopping_list/gateway/input/find_last_shopping_list_input.dart';

class ShoppingListStore {
  List<String> _historyOfCodes;
  String _currentCode;
  static final ShoppingListStore _instance = ShoppingListStore._internal();
  final findCurrentShoppingList = Modular.get<FindCurrentShoppingListInput>();
  final findLastShoppingLists = Modular.get<FindLastShoppingListInput>();

  factory ShoppingListStore() {
    return _instance;
  }

  ShoppingListStore._internal() {
    getListsFromStorage();
    Future.delayed(Duration(seconds: 1));
  }

  void getListsFromStorage() async {
    this._historyOfCodes = (await findLastShoppingLists.execute())
        .map((shoppingList) => shoppingList.code).toList();
    this._currentCode = (await findCurrentShoppingList.execute())?.code;
  }

  String getCurrentList() {
    if (this._currentCode == null || this._currentCode == "") {
      if (this._historyOfCodes != null && this._historyOfCodes.length > 0) {
        return this._historyOfCodes.last;
      } else {
        return null;
      }
    } else {
      return this._currentCode;
    }
  }

  List<String> getLastShoppingLists() {
    if (_historyOfCodes == null) {
      return [];
    }
    return _historyOfCodes;
  }

  void setCurrentCode(String newCode) {
    this._currentCode = newCode;
  }

  void addNewCodeToHistoric(String newCode) {
    this._historyOfCodes.removeWhere((listCode) => listCode == newCode);
    this._historyOfCodes.add(newCode);
  }
}
