class UpdateItemDTO {
  String id;
  String shoppingListCode;
  bool newStatus;

  UpdateItemDTO(this.id, this.shoppingListCode, this.newStatus);
}
