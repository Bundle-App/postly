import 'package:Postly/util/validator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Form Validate test', () {
    test('when form is empty', () {
      var result = FormValidator.validate('');
      expect(result, 'Field cannot be empty');
    });
    test('when entry is less than 5', () {
      var result = FormValidator.validate('jdd');
      expect(result, 'text should be 5 or more characters');
    });

    test('when entry is more than 5', () {
      var result = FormValidator.validate('jddkfjkljdkfjkdjkfjkd');
      expect(result, null);
    });
  });
}
