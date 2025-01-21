//Dependency Injection
import 'package:fpdart/fpdart.dart';

//Core Entities
import '../../../../core/common/entities/user.dart';

//Core Failures
import '/core/error/failures.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, User>> singUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });
  Future<Either<Failure, User>> loginWithEmailPassword({
    required String email,
    required String password,
  });
  Future<Either<Failure, User>> currentUser();
}