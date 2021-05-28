class TitleValidator {
  static String validate(String value) {
    if (value.isEmpty) {
      return 'Field cannot be empty';
    }
    if (value.length <= 5) {
      return 'should be 5 or more characters';
    }
    return null;
  }
}
