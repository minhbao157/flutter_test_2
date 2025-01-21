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

class UserSignUp implements UseCase<User, UserSignUpParams>{
  final AuthRepository authRepository;
  const UserSignUp(this.authRepository);

  @override
  Future<Either<Failure, User>> call(UserSignUpParams params) async{
    return await authRepository.singUpWithEmailPassword(
        name: params.name, 
        email: params.email, 
        password: params.password
    );
  }
}

class UserSignUpParams {
    final String email;
    final String password;
    final String name;
    UserSignUpParams({
        required this.email,
        required this.password,
        required this.name,
    });
}

