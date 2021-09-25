import 'package:dartz/dartz.dart';
import 'package:shopping_list/application/shopping_list/gateway/storage/storage_shopping_list_repository.dart';
import 'package:shopping_list/domain/exceptions/not_found_exception.dart';
import 'package:shopping_list/domain/shopping_list/gateway/output/find_current_shopping_list_gateway.dart';
import 'package:shopping_list/domain/shopping_list/model/shopping_list.dart';

class FindCurrentShoppingListProvider implements FindCurrentShoppingListGateway {
  final StorageShoppingListRepository storageShoppingListRepository;

  FindCurrentShoppingListProvider(this.storageShoppingListRepository);

  @override
  Future<Either<NotFoundException, ShoppingList>> execute() async {
    final currentList = await storageShoppingListRepository.findCurrentShoppingList();
    if (currentList == null || currentList.isLeft()) return Left(currentList.fold((l) => l, (r) => null));
    return Right(currentList.getOrElse(() => null)?.toDomain());
  }
}
