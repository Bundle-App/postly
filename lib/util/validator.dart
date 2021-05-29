//This is to validate the create post form
class FormValidator {
  static String validate(String value) {
    if (value.isEmpty) {
      return 'Field cannot be empty';
    }
    if (value.length <= 5) {
      return 'text should be 5 or more characters';
    }
    return null;
  }
}
