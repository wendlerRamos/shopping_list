abstract class CheckIfFieldIsNumber{
  String execute(String textValue);
}

class CheckIfFieldIsNumberImplementation implements CheckIfFieldIsNumber{

  String execute(String textValue) {
    double parsedNumber = double.tryParse(textValue.replaceAll(new RegExp(r','), '.'));
    return parsedNumber != null ? null : "";
  }

}