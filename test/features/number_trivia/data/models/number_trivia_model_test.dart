import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:numbers_trivia/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:numbers_trivia/features/number_trivia/domain/entities/number_trivia.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tNumberTriviaModel = NumberTriviaModel(number: 1, text: 'test');

  test(
    'should be a subclass of NumberTriviaEntity',
    () async {
      // Arrange
      expect(tNumberTriviaModel, isA<NumberTrivia>());
      // Act

      // Assert
    },
  );

  group('fromJson', () {
    test(
      'should return a valid model when the JSON number is integer',
      () async {
        // Arrange
        final Map<String, dynamic> jsonMap =
            json.decode(fixture('trivia.json'));
        // Act
        final result = NumberTriviaModel.fromJson(jsonMap);
        // Assert
        expect(result, tNumberTriviaModel);
      },
    );

    test(
      'should return a valid model when the JSON number is double',
      () async {
        // Arrange
        final Map<String, dynamic> jsonMap =
            json.decode(fixture('trivia_double.json'));
        // Act
        final result = NumberTriviaModel.fromJson(jsonMap);
        // Assert
        expect(result, tNumberTriviaModel);
      },
    );
  });

  group('toJson', () {
    test(
      'should return a JSON map containing the proper data',
      () async {
        // Arrange
        final result = tNumberTriviaModel.toJson();
        // Act
        final expectedJsonMap = {
          "text": "test",
          "number": 1,
        };
        // Assert
        expect(result, expectedJsonMap);
      },
    );
  });
}
