import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shopping_list/application/shopping_list/gateway/provider/find_current_shopping_list_provider.dart';
import 'package:shopping_list/application/shopping_list/gateway/storage/domain/shopping_list_storage_dto.dart';
import 'package:shopping_list/application/shopping_list/gateway/storage/storage_shopping_list_repository.dart';
import 'package:shopping_list/domain/exceptions/not_found_exception.dart';
import 'package:shopping_list/domain/shopping_list/model/shopping_list.dart';

class StorageShoppingListRepositoryMock extends Mock implements StorageShoppingListRepository {}

main() {
  final storageRepository = StorageShoppingListRepositoryMock();
  final target = FindCurrentShoppingListProvider(storageRepository);

  test('should find current shopping list on memory successfully', () async {
    final shoppingListDto = ShoppingListStorageDto("abcde");
    when(storageRepository.findCurrentShoppingList()).thenAnswer((_) async => Right(shoppingListDto));
    final result = await target.execute();
    expect(result | null, isA<ShoppingList>());
  });

  test('should be left when current shopping list does not exists', () async {
    when(storageRepository.findCurrentShoppingList()).thenAnswer((_) async => Left(NotFoundException("")));
    final result = await target.execute();
    expect(result.fold(id, id), isA<NotFoundException>());
  });
}
