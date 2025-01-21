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

class CurrentUser implements UseCase<User, NoParams>{
  final AuthRepository authRepository;
  CurrentUser(this.authRepository);
  
  @override
  Future<Either<Failure, User>> call(NoParams params) async{
    return await authRepository.currentUser();
  }

}
