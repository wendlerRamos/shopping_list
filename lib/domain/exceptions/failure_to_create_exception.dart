import 'package:shopping_list/domain/exceptions/failure.dart';

class FailureToCreateException implements Failure {
  @override
  String message;

  FailureToCreateException(this.message);

}