import 'package:shopping_list/application/shopping_list/gateway/storage/storage_shopping_list_repository.dart';
import 'package:shopping_list/presenter/core/controller/shopping_list_store.dart';
import 'package:shopping_list/domain/shopping_list/gateway/output/update_current_list_gateway.dart';
import 'package:shopping_list/domain/shopping_list/model/shopping_list.dart';

class UpdateCurrentShoppingListProvider
    implements UpdateCurrentShoppingListGateway {
  final StorageShoppingListRepository storageShoppingListRepository;

  UpdateCurrentShoppingListProvider(this.storageShoppingListRepository);

  @override
  void execute(ShoppingList shoppingList) {
    storageShoppingListRepository.setCurrentCode(shoppingList.code);
    storageShoppingListRepository.addNewCodeToHistoric(shoppingList.code);
    var listCode = ShoppingListStore();
    listCode.setCurrentCode(shoppingList.code);
    listCode.addNewCodeToHistoric(shoppingList.code);
  }
}
