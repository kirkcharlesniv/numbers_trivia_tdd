import 'package:dartz/dartz.dart';
import 'package:numbers_trivia/core/failures.dart';
import 'package:numbers_trivia/core/usecase.dart';
import 'package:numbers_trivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:numbers_trivia/features/number_trivia/domain/repositories/number_trivia_repository.dart';

class GetConcreteNumberTrivia extends UseCase {
  final NumberTriviaRepository numberTriviaRepository;

  GetConcreteNumberTrivia(this.numberTriviaRepository);

  @override
  Future<Either<Failure, NumberTrivia>> call(params) async {
    return await numberTriviaRepository.getConcreteNumberTrivia(params.number);
  }
}
