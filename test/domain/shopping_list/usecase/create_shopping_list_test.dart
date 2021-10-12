import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shopping_list/domain/exceptions/failure.dart';
import 'package:shopping_list/domain/exceptions/not_found_exception.dart';
import 'package:shopping_list/domain/shopping_list/gateway/output/find_shopping_list_by_code_gateway.dart';
import 'package:shopping_list/domain/shopping_list/gateway/output/save_shopping_list_gateway.dart';
import 'package:shopping_list/domain/shopping_list/gateway/output/update_current_list_gateway.dart';
import 'package:shopping_list/domain/shopping_list/model/shopping_list.dart';
import 'package:shopping_list/domain/shopping_list/usecase/create_shopping_list.dart';
import 'package:shopping_list/domain/utils/usecase/generate_random_code.dart';

import '../../util/mock_util.dart';

class SaveShoppingListGatewayMock extends Mock implements SaveShoppingListGateway {}

class GenerateRandomCodeMock extends Mock implements GenerateRandomCode {}

class FindShoppingListByCodeGatewayMock extends Mock implements FindShoppingListByCodeGateway {}

class UpdateCurrentShoppingListGatewayMock extends Mock
    implements UpdateCurrentShoppingListGateway {}

main() {
  final saveShoppingListGateway = SaveShoppingListGatewayMock();
  final generateRandomCode = GenerateRandomCodeMock();
  final findShoppingListByCodeGateway = FindShoppingListByCodeGatewayMock();
  final updateCurrentShoppingListGateway = UpdateCurrentShoppingListGatewayMock();

  final createShoppingList = CreateShoppingList(findShoppingListByCodeGateway,
      saveShoppingListGateway, generateRandomCode, updateCurrentShoppingListGateway);

  test("should create a list by code successfully", () async {
    String code = "Ab0e2";
    ShoppingList targetShoppingList = MockUtil.createShoppingList(code);
    when(generateRandomCode.execute(5)).thenAnswer((realInvocation) => code);
    when(findShoppingListByCodeGateway.execute(code))
        .thenAnswer((realInvocation) async => Left(NotFoundException()));
    when(saveShoppingListGateway.execute(code))
        .thenAnswer((realInvocation) async => Right(targetShoppingList));
    when(updateCurrentShoppingListGateway.execute(targetShoppingList))
        .thenAnswer((realInvocation) {});
    final result = await createShoppingList.execute();
    expect(result | null, isA<ShoppingList>());
    expect(targetShoppingList, result | null);
    verify(updateCurrentShoppingListGateway.execute(targetShoppingList));
  });

  test("should not create shopping list when code already exists", () async {
    String code = "Ab0e2";
    ShoppingList targetShoppingList = MockUtil.createShoppingList(code);
    when(generateRandomCode.execute(5)).thenAnswer((realInvocation) => code);
    when(findShoppingListByCodeGateway.execute(code))
        .thenAnswer((realInvocation) async => Right(targetShoppingList));

    final result = await createShoppingList.execute();
    verifyNever(saveShoppingListGateway.execute(any));

    expect(result | null, null);
    expect(result.fold(id, id), isA<Failure>());
  });
}
