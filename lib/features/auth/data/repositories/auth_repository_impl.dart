// Dependency Injection
import 'package:fpdart/fpdart.dart';

//Supabase Integration
import 'package:supabase_flutter/supabase_flutter.dart' as sb;

//Core Entities
import '../../../../core/common/entities/user.dart';

//Core Error Handling
import '/core/error/failures.dart';
import '/core/error/exceptions.dart';

//Domain Repository Interface
import '../../domain/repository/auth_repository.dart';

//Remote Data Source
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository{
  final AuthRemoteDataSource remoteDataSource;
  const AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, User>> currentUser() async{
    try{
      final user = await remoteDataSource.getCurrentUserData();
      if(user == null){
        return left(Failure('User not logged in'));
      }
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
  
  @override
  Future<Either<Failure, User>> loginWithEmailPassword({
    required String email, 
    required String password
  }) async{
      return _getUser(
        () async => await remoteDataSource.loginWithEmailPassword(
          email: email, 
          password: password,
        ),
      );
    }

  @override
  Future<Either<Failure, User>> singUpWithEmailPassword({
    required String name,
    required String email, 
    required String password
  }) async {
      return _getUser(
        () async => await remoteDataSource.singUpWithEmailPassword(
          name: name, 
          email: email, 
          password: password
        ),
      );
    }

  Future<Either<Failure, User>> _getUser(
    Future<User> Function() fn,
  ) async {
    try{
      final user = await fn();
      return right(user);
    } on sb.AuthException catch (e) {
      return left(Failure(e.message));
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}