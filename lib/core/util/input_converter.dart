import 'package:dartz/dartz.dart';
import '../failures.dart';

class InputConverter {
  Either<Failure, int> stringToUnsignedInt(String string) {
    try {
      final integer = int.parse(string);
      if (integer < 0) throw FormatException();
      return Right(integer);
    } on FormatException {
      return Left(InputInvalidFailure());
    }
  }
}

class InputInvalidFailure extends Failure {}
