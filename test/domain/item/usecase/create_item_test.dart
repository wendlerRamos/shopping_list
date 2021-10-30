import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shopping_list/domain/exceptions/failure.dart';
import 'package:shopping_list/domain/exceptions/not_found_exception.dart';
import 'package:shopping_list/domain/item/gateway/output/save_item_gateway.dart';
import 'package:shopping_list/domain/item/model/Item.dart';
import 'package:shopping_list/domain/item/usecase/create_item_usecase.dart';
import 'package:shopping_list/domain/shopping_list/gateway/output/find_current_shopping_list_gateway.dart';
import '../../util/mock_util.dart';

class FindCurrentListGatewayMock extends Mock implements FindCurrentShoppingListGateway {}

class SaveItemGatewayMock extends Mock implements SaveItemGateway {}

main() {
  final findCurrentRepositoryGateway = FindCurrentListGatewayMock();
  final saveItemGateway = SaveItemGatewayMock();
  final createItemUsecase = CreateItemUsecase(findCurrentRepositoryGateway, saveItemGateway);

  test("should create an item successfully", () async {
    final currentShoppingList = MockUtil.createShoppingList("abcde");
    final item = MockUtil.createItem();

    when(findCurrentRepositoryGateway.execute()).thenAnswer((_) async => Right(currentShoppingList));
    when(saveItemGateway.execute(item, currentShoppingList.code)).thenAnswer((realInvocation) async => Right(item));

    final result = await createItemUsecase.execute(item);
    expect(result | null, isA<Item>());
  });

  test("should failure when current list does not exists", () async {
    final item = MockUtil.createItem();
    when(findCurrentRepositoryGateway.execute()).thenAnswer((_) async => Left(NotFoundException("")));
    final result = await createItemUsecase.execute(item);
    expect(result.isLeft(), true);
    expect(result.fold(id, id), isA<NotFoundException>());
    verifyNever(saveItemGateway.execute(any, any));
  });

  test("should failure when could not create item", () async {
    final currentShoppingList = MockUtil.createShoppingList("abcde");
    final item = MockUtil.createItem();

    when(findCurrentRepositoryGateway.execute()).thenAnswer((_) async => Right(currentShoppingList));
    when(saveItemGateway.execute(item, currentShoppingList.code)).thenAnswer((_) async => Left(Failure()));

    final result = await createItemUsecase.execute(item);
    expect(result | null, null);
    expect(result.fold(id, id), isA<Failure>());
  });
}
