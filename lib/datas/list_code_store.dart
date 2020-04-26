import 'package:shared_preferences/shared_preferences.dart';


class ListCode{
  List<String> _historyOfCodes;
  String _currentCode; 
  static final ListCode _instance = ListCode._internal();
  
  factory ListCode(){
    return _instance;
  }

  ListCode._internal(){
    getListsFromStorage();
    Future.delayed(Duration(seconds: 1));
  }

  void getListsFromStorage() async {
    final _storageInstance = await SharedPreferences.getInstance();
    this._historyOfCodes = _storageInstance.getStringList('list_codes') ?? [];
    this._currentCode = (_storageInstance.getString('current_code') ?? null);
  }

  String getCurrentList(){
    if(this._currentCode == null || this._currentCode == ""){
      if(this._historyOfCodes != null &&  this._historyOfCodes.length > 0){
        return this._historyOfCodes.last;
      }else{
        return null;
      }
    }else{
      return this._currentCode;
    }
  }

  void setCurrentList(String newCode) async {
    final _storageInstance = await SharedPreferences.getInstance();
    this._currentCode = newCode;
    _historyOfCodes.removeWhere((item) => item == newCode);
    _historyOfCodes.add(newCode);
    _storageInstance.setString('current_code', this._currentCode);
    _storageInstance.setStringList('list_codes', this._historyOfCodes);
  }

  List<String> getLastShoppingLists(){
    if(_historyOfCodes == null){
      return [];
    }
    return _historyOfCodes;
  }

}