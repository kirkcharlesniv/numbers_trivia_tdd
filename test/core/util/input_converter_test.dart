import 'package:dartz/dartz.dart';
import 'package:matcher/matcher.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:numbers_trivia/core/util/input_converter.dart';

void main() {
  InputConverter inputConverter;

  setUp(() {
    inputConverter = InputConverter();
  });

  group('stringToUnsignedInt', () {
    test(
      'should return an int when the string represents an unsigned int',
      () async {
        // Arrange
        final str = '123';
        // Act
        final result = inputConverter.stringToUnsignedInt(str);
        // Assert
        expect(result, Right(123));
      },
    );
    test(
      'should return an failure when the string does not represent an unsigned int',
      () async {
        // Arrange
        final str = 'Test Text';
        // Act
        final result = inputConverter.stringToUnsignedInt(str);
        // Assert
        expect(result, equals(Left(InputInvalidFailure())));
      },
    );
    test(
      'should return a failure when the integer is below 0',
      () async {
        // Arrange
        final str = '-123';
        // Act
        final result = inputConverter.stringToUnsignedInt(str);
        // Assert
        expect(result, equals(Left(InputInvalidFailure())));
      },
    );
  });
}
