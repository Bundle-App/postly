class FieldValidator {
  static String? validateText(String? value) {
    if (value!.isEmpty) return 'Field cannot be empty';

    return null;
  }
}
