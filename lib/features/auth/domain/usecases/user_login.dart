//Dependency Injection
import 'package:fpdart/fpdart.dart';

//Core Entities
import '../../../../core/common/entities/user.dart';

//Core Failures
import '../../../../core/error/failures.dart';

//UseCase Base Class
import '../../../../core/usecase/usecase.dart';

//Domain Repository Interface
import '../repository/auth_repository.dart';

class UserLogin implements UseCase<User, UserLoginParams> {
  final AuthRepository authRepository;
  const UserLogin(this.authRepository);

  @override
  Future<Either<Failure, User>> call(UserLoginParams params) async {
    return await authRepository.loginWithEmailPassword(
      email: params.email,
      password: params.password,
    );
  }
}

class UserLoginParams {
  final String email;
  final String password;

  UserLoginParams({
    required this.email,
    required this.password,
  });
}