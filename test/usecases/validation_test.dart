import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../mocks/mocks.mocks.dart';


void main() {
  late MockFormValidator mockFormValidator;

  setUp(() {
    mockFormValidator = MockFormValidator();
  });

  group('FormValidator Tests', () {
    test('Validates username successfully', () {
      when(mockFormValidator.validateUsername('validUsername'))
          .thenReturn(null); // Null means no error

      final result = mockFormValidator.validateUsername('validUsername');
      expect(result, isNull); // Expect no error
    });

    test('Returns error for empty username', () {
      when(mockFormValidator.validateUsername(''))
          .thenReturn('Username is required');

      final result = mockFormValidator.validateUsername('');
      expect(result, 'Username is required'); // Check for expected error
    });

    test('Validates password length successfully', () {
      when(mockFormValidator.validatePassword('12345678'))
          .thenReturn(null);

      final result = mockFormValidator.validatePassword('12345678');
      expect(result, isNull);
    });

    test('Returns error for short password', () {
      when(mockFormValidator.validatePassword('123'))
          .thenReturn('Password must be at least 8 characters long');

      final result = mockFormValidator.validatePassword('123');
      expect(result, 'Password must be at least 8 characters long');
    });
  });
}
