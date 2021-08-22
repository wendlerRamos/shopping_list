import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_list/application/shopping_list/gateway/storage/domain/shopping_list_storage_dto.dart';
import 'package:shopping_list/domain/exceptions/not_found_exception.dart';

class StorageShoppingListRepository {

  //final SharedPreferences sharedPreferences;

  //StorageShoppingListRepository(this.sharedPreferences);

  Future<Either<NotFoundException, ShoppingListStorageDto>> findCurrentShoppingList() async{
    try{
      //TODO("Update to injection when change flutter modular version")
      final sharedPreferences = await SharedPreferences.getInstance();
      final currentCode = (sharedPreferences.getString('current_code') ?? null);
      return (currentCode != null) ? Right(ShoppingListStorageDto(currentCode)) : Left(NotFoundException());
    }catch(Exception){
      return Left(NotFoundException());
    }
  }
}
