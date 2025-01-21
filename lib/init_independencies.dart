//Dependency Injection
import 'package:get_it/get_it.dart';
import 'package:namer_app/features/Home/data/models/datasources/pond_remote_data_source.dart';
import 'package:namer_app/features/Home/data/repositories/pond_repository_imp.dart';
import 'package:namer_app/features/Home/domain/repositories/pond_repository.dart';
import 'package:namer_app/features/Home/domain/usecases/get_all_ponds.dart';
import 'package:namer_app/features/Home/domain/usecases/upload_pond.dart';
import 'package:namer_app/features/Home/presentation/pond/pond_bloc.dart';

//Supabase Flutter
import 'package:supabase_flutter/supabase_flutter.dart';

//Application Secrets
import 'core/secrets/app_secrets.dart';

//UseCases
import 'features/auth/domain/usecases/user_login.dart';
import 'features/auth/domain/usecases/user_sign_up.dart';
import 'features/auth/domain/usecases/current_user.dart';

//Repository Interface
import 'features/auth/domain/repository/auth_repository.dart';

//Repository Implementation
import 'features/auth/data/repositories/auth_repository_impl.dart';

//Remote Data Source
import 'features/auth/data/datasources/auth_remote_data_source.dart';

//Bloc
import 'features/auth/presentation/bloc/auth_bloc.dart';

//Cubit
import 'features/auth/presentation/cubits/app_user/app_user_cubit.dart';

final serviceLocator = GetIt.instance;

Future<void> initInDependencies() async {
  _initAuth();
  _initPond();
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseURL, 
    anonKey: AppSecrets.supabaseAnonKey,
  );
  serviceLocator.registerLazySingleton(() => supabase.client);

  //core
  serviceLocator.registerLazySingleton(() => AppUserCubit());
}

void _initAuth() {
  //Datasource
  serviceLocator
  ..registerFactory<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      serviceLocator(),
    ),
  )
  //Repository
  ..registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(
      serviceLocator(),
    ),
  )
  ..registerFactory(
    () => UserSignUp(
      serviceLocator(),
    ),
  )
  ..registerFactory(
    () => UserLogin(
      serviceLocator(),
    ),
  )
  ..registerFactory(
    () => CurrentUser(
      serviceLocator()
    ),
  )  
  //Bloc
  ..registerLazySingleton(
    () => AuthBloc(
      userSignUp: serviceLocator(),
      userLogin: serviceLocator(),
      currentUser: serviceLocator(),
      appUserCubit: serviceLocator(),
    ),
  );
}

void _initPond() {
  //Datasource
  serviceLocator
  ..registerFactory<PondRemoteDataSource>(
    () => PondRemoteDataSourceImpl(
      serviceLocator(),
    ),
  )
  //Repository
  ..registerFactory<PondRepository>(
    () => PondRepositoryImp(
      serviceLocator(),
    ),
  )
  //Usecases
  ..registerFactory(
    () => UploadPond(
      serviceLocator(),
    ),
  )
  ..registerFactory(
    () => GetAllPonds(
      serviceLocator(),
    ),
  )
  //Bloc
  ..registerLazySingleton(
    () => PondBloc(
      uploadPond:  serviceLocator(),
      getAllPonds: serviceLocator(),
    ),
  )
  ;
}