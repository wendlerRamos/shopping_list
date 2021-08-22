import 'package:dartz/dartz.dart';
import 'package:shopping_list/application/item/gateway/firebase/domain/ItemDto.dart';
import 'package:shopping_list/application/item/gateway/firebase/firebase_item_service.dart';
import 'package:shopping_list/domain/exceptions/failure.dart';
import 'package:shopping_list/domain/item/gateway/save_item_gateway.dart';
import 'package:shopping_list/domain/item/model/Item.dart';

class SaveItemProvider implements SaveItemGateway {

  final FirebaseItemService firebaseItemService;

  SaveItemProvider(this.firebaseItemService);

  @override
  Future<Either<Failure, Item>> execute(Item item, String listCode) async {
    firebaseItemService.saveItemToList(ItemDto.fromDomain(item), listCode);
    return Right(item);
  }

}