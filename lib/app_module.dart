import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shopping_list/app_widget.dart';
import 'package:shopping_list/application/item/entrypoint/item_controller.dart';
import 'package:shopping_list/application/item/gateway/firebase/firebase_item_service.dart';
import 'package:shopping_list/application/item/gateway/provider/save_item_provider.dart';
import 'package:shopping_list/application/shopping_list/gateway/provider/find_current_shopping_list_provider.dart';
import 'package:shopping_list/application/shopping_list/gateway/storage/storage_shopping_list_repository.dart';
import 'package:shopping_list/domain/item/usecase/create_item_usecase.dart';
import 'package:shopping_list/presenter/item/controller/parse_form_to_item_dto.dart';
import 'package:shopping_list/presenter/util/controller/check_if_field_is_empty.dart';
import 'package:shopping_list/presenter/util/controller/parse_string_to_monetary_value.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        Bind((inject) => CreateItemUsecase(inject(), inject())),
        Bind((inject) => SaveItemProvider(inject())),
        Bind((inject) => FirebaseItemService(inject())),
        Bind((inject) => Firestore.instance),
        Bind((inject) => FindCurrentShoppingListProvider(inject())),
        Bind((inject) => StorageShoppingListRepository()),
        Bind((inject) => ItemControllerImplementation(inject())),
        Bind((inject) => CheckIfFieldIsEmptyImplementation()),
        Bind((inject) => ParseFormToItemDtoImplementation()),
        Bind((inject) => ParseStringToMonetaryValueImplementation()),
      ];

  @override
  Widget get bootstrap => AppWidget();

  @override
  List<ModularRouter> get routers => throw UnimplementedError();
}
