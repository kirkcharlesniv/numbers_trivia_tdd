import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:numbers_trivia/core/failures.dart';
import 'package:meta/meta.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => null;
}

class Params extends Equatable {
  final int number;

  Params({@required this.number});

  @override
  List<Object> get props => [number];
}
