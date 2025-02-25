//Flutter Core Packages
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//Core Entities
import '../../../../core/common/entities/user.dart';

//UseCase Base Class
import '../../../../core/usecase/usecase.dart';

//Domain UseCases
import '../../domain/usecases/current_user.dart';
import '../../domain/usecases/user_login.dart';
import '../../domain/usecases/user_sign_up.dart';

//Cubit
import '../cubits/app_user/app_user_cubit.dart';

//Bloc Parts
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserLogin _userLogin;
  final CurrentUser _currentUser;
  final AppUserCubit _appUserCubit;
  AuthBloc({
    required UserSignUp userSignUp,
    required UserLogin userLogin,
    required CurrentUser currentUser,
    required AppUserCubit appUserCubit,
  }) : _userSignUp = userSignUp,
      _userLogin = userLogin,
      _currentUser = currentUser,
      _appUserCubit = appUserCubit,
       super(AuthInitial()) {
    on<AuthEvent>((_, emit,) => emit(AuthLoading(),),);
    on<AuthSignUp>(_onAuthSignUp);
    on<AuthLogin>(_onAuthLogin);
    on<AuthIsUserLoggedIn>(_isUserLoggedIn);
  }

  void _isUserLoggedIn(AuthIsUserLoggedIn event, Emitter<AuthState> emit) async {
    final res = await _currentUser(NoParams());
    res.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (user) => _emitAuthSuccess(user, emit),
    );
  }

  void _onAuthSignUp(
    AuthSignUp event,
    Emitter<AuthState> emit,
    ) async{
      final res = await _userSignUp(
        UserSignUpParams(
          email: event.email,
          password: event.password,
          name: event.name,
        ),
      );
      res.fold(
        (failure) => emit(AuthFailure(failure.message)),
        (user) => _emitAuthSuccess(user, emit),
      );
    }
  
  void _onAuthLogin (
      AuthLogin event,
      Emitter<AuthState> emit
    ) async{
    final res = await _userLogin(
      UserLoginParams(
        email: event.email, 
        password: event.password
      ),
    );
    res.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (user) => _emitAuthSuccess(user, emit),
    );
  }

  void _emitAuthSuccess (
    User user, 
    Emitter<AuthState> emit,
  ) {
    _appUserCubit.updateUser(user);
    emit(AuthSuccess(user));
  }
}
