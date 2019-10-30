import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:numbers_trivia/core/exception.dart';
import 'package:numbers_trivia/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:numbers_trivia/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:matcher/matcher.dart';
import '../../../../fixtures/fixture_reader.dart';

class MockHttp extends Mock implements http.Client {}

void main() {
  NumberTriviaRemoteDataSourceImplementation
      numberTriviaRemoteDataSourceImplementation;
  MockHttp mockHttp;

  setUp(() {
    mockHttp = MockHttp();
    numberTriviaRemoteDataSourceImplementation =
        NumberTriviaRemoteDataSourceImplementation(httpClient: mockHttp);
  });

  void setUpMockHttpClientSuccess() {
    when(mockHttp.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response(fixture('trivia.json'), 200));
  }

  void setUpMockHttpClientFail() {
    when(mockHttp.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('Something went wrong...', 404));
  }

  group('getConcreteNumberTrivia', () {
    final tNumber = 1;
    final tNumberTriviaModel = NumberTriviaModel(number: 1, text: 'Test Text');
    test(
      'should preform a GET request on a URL with number being the endpoint and with application/json header',
      () async {
        // Arrange
        setUpMockHttpClientSuccess();
        // Act
        numberTriviaRemoteDataSourceImplementation
            .getConcreteNumberTrivia(tNumber);
        // Assert
        verify(mockHttp.get(
          'http://numbersapi.com/$tNumber',
          headers: {'Content-Type': 'application/json'},
        ));
      },
    );
    test(
      'should return a proper model data when the response code is 200',
      () async {
        // Arrange
        setUpMockHttpClientSuccess();
        // Act
        final result = await numberTriviaRemoteDataSourceImplementation
            .getConcreteNumberTrivia(tNumber);
        // Assert
        expect(result, equals(tNumberTriviaModel));
      },
    );

    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // Arrange
        setUpMockHttpClientFail();
        // Act
        final call =
            numberTriviaRemoteDataSourceImplementation.getConcreteNumberTrivia;
        // Assert
        expect(() => call(tNumber), throwsA(TypeMatcher<ServerException>()));
      },
    );
  });

  group('getRandomNumberTrivia', () {
    final tNumberTriviaModel = NumberTriviaModel(number: 1, text: 'Test Text');
    test(
      'should preform a GET request on a URL with application/json header',
      () async {
        // Arrange
        setUpMockHttpClientSuccess();
        // Act
        numberTriviaRemoteDataSourceImplementation.getRandomNumberTrivia();
        // Assert
        verify(mockHttp.get(
          'http://numbersapi.com/random',
          headers: {'Content-Type': 'application/json'},
        ));
      },
    );

    test(
      'should return a proper model data when the response code is 200',
      () async {
        // Arrange
        setUpMockHttpClientSuccess();
        // Act
        final result = await numberTriviaRemoteDataSourceImplementation
            .getRandomNumberTrivia();
        // Assert
        expect(result, equals(tNumberTriviaModel));
      },
    );

    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // Arrange
        setUpMockHttpClientFail();
        // Act
        final call =
            numberTriviaRemoteDataSourceImplementation.getRandomNumberTrivia;
        // Assert
        expect(() => call(), throwsA(TypeMatcher<ServerException>()));
      },
    );
  });
}
