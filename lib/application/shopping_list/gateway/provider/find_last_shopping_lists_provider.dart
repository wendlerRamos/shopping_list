import 'package:shopping_list/application/shopping_list/gateway/storage/storage_shopping_list_repository.dart';
import 'package:shopping_list/domain/shopping_list/gateway/output/find_last_shopping_lists_gateway.dart';
import 'package:shopping_list/domain/shopping_list/model/shopping_list.dart';

class FindLastShoppingListsProvider implements FindLastShoppingListsGateway {
  final StorageShoppingListRepository storageShoppingListRepository;

  FindLastShoppingListsProvider(this.storageShoppingListRepository);

  @override
  Future<List<ShoppingList>> execute() async {
    return (await storageShoppingListRepository.findShoppingListsOnHistoric())
        .map((it) => it.toDomain()).toList();
  }
}
