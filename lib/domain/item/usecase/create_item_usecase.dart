import 'package:dartz/dartz.dart';
import 'package:shopping_list/domain/exceptions/failure.dart';
import 'package:shopping_list/domain/item/gateway/input/create_item_input.dart';
import 'package:shopping_list/domain/item/gateway/output/save_item_gateway.dart';
import 'package:shopping_list/domain/item/model/Item.dart';
import 'package:shopping_list/domain/shopping_list/gateway/output/find_current_shopping_list_gateway.dart';

class CreateItemUsecase implements CreateItemInput {
  final FindCurrentShoppingListGateway findCurrentShoppingListGateway;

  final SaveItemGateway saveItemGateway;

  CreateItemUsecase(this.findCurrentShoppingListGateway, this.saveItemGateway);

  @override
  Future<Either<Failure, Item>> execute(Item item) async {
    final currentList = await findCurrentShoppingListGateway.execute();
    if (currentList.isLeft()) return Left(currentList.fold((l) => l, (r) => null));
    final savedItem = saveItemGateway.execute(item, currentList.getOrElse(() => null).code);
    return savedItem;
  }
}
