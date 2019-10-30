import 'dart:convert';

import 'package:matcher/matcher.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:numbers_trivia/core/exception.dart';
import 'package:numbers_trivia/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:numbers_trivia/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../fixtures/fixture_reader.dart';

const CACHED_NUMBER_TRIVIA = 'CACHED_NUMBER_TRIVIA';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  NumberTriviaLocalDataSourceImplementation numberTriviaLocalDataSource;
  MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    numberTriviaLocalDataSource = NumberTriviaLocalDataSourceImplementation(
        sharedPreferences: mockSharedPreferences);
  });

  group('get last number trivia', () {
    final NumberTriviaModel tNumberTriviaModel =
        NumberTriviaModel(number: 1, text: 'Test Text');
    test(
      'should return the latest NumberTrivia from the SharedPreferences when there is one in the cache',
      () async {
        // Arrange
        when(mockSharedPreferences.getString(any))
            .thenReturn(fixture('trivia_cached.json'));
        // Act
        final result = await numberTriviaLocalDataSource.getLastNumberTrivia();
        // Assert
        verify(mockSharedPreferences.getString(CACHED_NUMBER_TRIVIA));
        expect(result, equals(tNumberTriviaModel));
      },
    );
    test(
      'should throw a CacheExeption when there is not a cached value',
      () async {
        // arrange
        when(mockSharedPreferences.getString(any)).thenReturn(null);
        // act
        final call = numberTriviaLocalDataSource.getLastNumberTrivia;
        // assert
        expect(() => call(), throwsA(TypeMatcher<CacheException>()));
      },
    );
  });

  group('cache number trivia', () {
    final tNumberTriviaModel = NumberTriviaModel(text: 'Test Text', number: 1);
    test(
      'should call the SharedPreferences to cache the data',
      () async {
        // Act
        numberTriviaLocalDataSource.cacheNumberTrivia(tNumberTriviaModel);
        // Assert
        final expectedJsonString = json.encode(tNumberTriviaModel);
        verify(mockSharedPreferences.setString(
            CACHED_NUMBER_TRIVIA, expectedJsonString));
      },
    );
  });
}
