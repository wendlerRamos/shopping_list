import 'package:dartz/dartz.dart';
import 'package:shopping_list/domain/exceptions/failure_to_create_exception.dart';
import 'package:shopping_list/domain/shopping_list/gateway/input/create_shopping_list_input.dart';
import 'package:shopping_list/domain/shopping_list/gateway/output/find_shopping_list_by_code_gateway.dart';
import 'package:shopping_list/domain/shopping_list/gateway/output/save_shopping_list_gateway.dart';
import 'package:shopping_list/domain/shopping_list/model/shopping_list.dart';
import 'package:shopping_list/domain/utils/usecase/generate_random_code.dart';

class CreateShoppingList implements CreateShoppingListInput {
  final FindShoppingListByCodeGateway findShoppingListByCodeGateway;
  final SaveShoppingListGateway saveShoppingListGateway;
  final GenerateRandomCode generateRandomCode;

  CreateShoppingList(
      this.findShoppingListByCodeGateway, this.saveShoppingListGateway, this.generateRandomCode);

  @override
  Future<Either<Exception, ShoppingList>> execute() async {
    int sizeOfCode = 5;
    int limitOfAttempts = 5;
    String newCodeList = '';
    bool isValidCode = false;
    int attempt = 0;
    do {
      attempt = attempt + 1;
      newCodeList = generateRandomCode.execute(sizeOfCode);
      isValidCode = !await checkIfListAlreadyExists(newCodeList);
    } while (!isValidCode && attempt < limitOfAttempts);

    if (!isValidCode) return Left(FailureToCreateException("Failure to create list"));

    return await saveShoppingListGateway.execute(newCodeList);
  }

  Future<bool> checkIfListAlreadyExists(String code) async {
    var resultSearch = await findShoppingListByCodeGateway.execute(code);
    return resultSearch.isRight();
  }
}
