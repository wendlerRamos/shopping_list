abstract class CheckIfFieldIsEmpty {
  String execute(String textValue);
}

class CheckIfFieldIsEmptyImplementation implements CheckIfFieldIsEmpty {
  String execute(String textValue) {
    return textValue.isEmpty ? "Campo obrigatório" : null;
  }
}
