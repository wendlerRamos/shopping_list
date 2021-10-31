
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shopping_list/app_widget.dart';
import 'package:shopping_list/application/item/entrypoint/item_controller.dart';
import 'package:shopping_list/application/item/gateway/firebase/firebase_item_service.dart';
import 'package:shopping_list/application/item/gateway/provider/delete_item_provider.dart';
import 'package:shopping_list/application/item/gateway/provider/save_item_provider.dart';
import 'package:shopping_list/application/item/gateway/provider/update_item_provider.dart';
import 'package:shopping_list/application/shopping_list/entrypoint/shopping_list_controller.dart';
import 'package:shopping_list/application/shopping_list/gateway/firebase/firebase_shopping_list_service.dart';
import 'package:shopping_list/application/shopping_list/gateway/provider/find_current_shopping_list_provider.dart';
import 'package:shopping_list/application/shopping_list/gateway/provider/find_last_shopping_lists_provider.dart';
import 'package:shopping_list/application/shopping_list/gateway/provider/find_shopping_list_by_code_provider.dart';
import 'package:shopping_list/application/shopping_list/gateway/provider/save_shopping_list_provider.dart';
import 'package:shopping_list/application/shopping_list/gateway/provider/update_current_shopping_list_provider.dart';
import 'package:shopping_list/application/shopping_list/gateway/storage/storage_shopping_list_repository.dart';
import 'package:shopping_list/domain/item/usecase/create_item_usecase.dart';
import 'package:shopping_list/domain/item/usecase/delete_item.dart';
import 'package:shopping_list/domain/item/usecase/update_item.dart';
import 'package:shopping_list/domain/shopping_list/usecase/create_shopping_list.dart';
import 'package:shopping_list/domain/shopping_list/usecase/find_current_shopping_list.dart';
import 'package:shopping_list/domain/shopping_list/usecase/find_last_shopping_lists.dart';
import 'package:shopping_list/domain/shopping_list/usecase/find_shopping_list_by_code.dart';
import 'package:shopping_list/domain/utils/usecase/generate_random_code.dart';
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
        Bind((inject) => ItemControllerImplementation(inject(), inject(), inject())),
        Bind((inject) => CheckIfFieldIsEmptyImplementation()),
        Bind((inject) => ParseFormToItemDtoImplementation()),
        Bind((inject) => ParseStringToMonetaryValueImplementation()),
        Bind((inject) => CreateShoppingList(inject(), inject(), inject(), inject())),
        Bind((inject) => ShoppingListController(inject(), inject(), inject(), inject())),
        Bind((inject) => FindShoppingListByCodeProvider(inject())),
        Bind((inject) => FirebaseShoppingListService(inject())),
        Bind((inject) => SaveShoppingListProvider(inject())),
        Bind((inject) => GenerateRandomCode()),
        Bind((inject) => FindLastShoppingLists(inject())),
        Bind((inject) => FindLastShoppingListsProvider(inject())),
        Bind((inject) => FindShoppingListByCode(inject(), inject())),
        Bind((inject) => UpdateCurrentShoppingListProvider(inject())),
        Bind((inject) => UpdateItem(inject())),
        Bind((inject) => UpdateItemProvider(inject())),
        Bind((inject) => DeleteItem(inject())),
        Bind((inject) => DeleteItemProvider(inject())),
        Bind((inject) => FindCurrentShoppingList(inject())),
      ];

  @override
  Widget get bootstrap => AppWidget();

  @override
  List<ModularRouter> get routers => throw UnimplementedError();
}
