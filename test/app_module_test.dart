import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shopping_list/app_module.dart';
import 'package:shopping_list/domain/item/gateway/input/create_item_input.dart';
import 'package:shopping_list/domain/item/usecase/create_item_usecase.dart';

class FirestoreMock extends Mock implements Firestore {}

main() {
  final firestore = FirestoreMock();

  initModule(AppModule(), changeBinds: [
    Bind<Firestore>((i) => firestore),
  ]);

  TestWidgetsFlutterBinding.ensureInitialized();

  test("should inject save item successfully", () {
    final createItemUsecase = Modular.get<CreateItemInput>();
    expect(createItemUsecase, isA<CreateItemUsecase>());
  });

  //TODO("Check class #5 to learn how to test end to end function")
  //Could not execute now because Shared Preferences can't be inject yet
}
