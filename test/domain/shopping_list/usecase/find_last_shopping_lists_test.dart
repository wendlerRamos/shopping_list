import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shopping_list/domain/shopping_list/gateway/output/find_last_shopping_lists_gateway.dart';
import 'package:shopping_list/domain/shopping_list/model/shopping_list.dart';
import 'package:shopping_list/domain/shopping_list/usecase/find_last_shopping_lists.dart';

class FindLastShoppingListsMock extends Mock implements FindLastShoppingListsGateway {}

main() {
  final findLastShoppingListsGateway = FindLastShoppingListsMock();

  final findLastShoppingLists = FindLastShoppingLists(findLastShoppingListsGateway);

  test("should return a list of shopping lists", () async {
    final firstCode = "aaa";
    final secondCode = "bbb";
    final expectedLists = [ShoppingList(firstCode), ShoppingList(secondCode)];

    when(findLastShoppingListsGateway.execute())
        .thenAnswer((realInvocation) async => expectedLists);

    final result = await findLastShoppingLists.execute();
    expect(result, expectedLists);
  });

  test("should return empty list when gateway fails", () async {
    final expectedResult = [];
    when(findLastShoppingListsGateway.execute()).thenThrow(Exception());
    final result = await findLastShoppingLists.execute();
    expect(result, expectedResult);
  });
}
