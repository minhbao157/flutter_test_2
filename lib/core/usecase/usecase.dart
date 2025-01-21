//Dependency Injection
import 'package:fpdart/fpdart.dart';

//Core Error Handling
import '../error/failures.dart';

abstract interface class UseCase<SuccessType, Params> {
  Future<Either<Failure, SuccessType>> call(Params params);
}

class NoParams{}