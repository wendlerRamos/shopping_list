import 'package:shopping_list/domain/exceptions/failure.dart';

class NotFoundException implements Failure {
  @override
  String message;
}