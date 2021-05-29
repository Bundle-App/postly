import 'package:flutter_test/flutter_test.dart';
import 'package:postly/core/utils/field_validator.dart';

void main() {
  group('Field Validator', () {
    group('Test validateText method', () {
      test('Test for empty field', () {
        var result = FieldValidator.validateText('');
        expect(result, 'Field cannot be empty');
      });

      test('Test for non-empty field', () {
        var result = FieldValidator.validateText('t');
        expect(result, null);
      });
    });
  });
}
