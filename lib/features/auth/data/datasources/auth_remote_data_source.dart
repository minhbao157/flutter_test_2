//Supabase Flutter
import 'package:supabase_flutter/supabase_flutter.dart';

//Core Error Handling
import '../../../../core/error/exceptions.dart';

//Models
import '../models/user_model.dart';

abstract interface class AuthRemoteDataSource {
  Session? get currentUserSession;
  Future<UserModel> singUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });
  Future<UserModel> loginWithEmailPassword({
    required String email,
    required String password,
  });
  Future<UserModel?> getCurrentUserData(); 
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient supabaseClient;
  AuthRemoteDataSourceImpl(this.supabaseClient);
  
  @override
  Session? get currentUserSession => supabaseClient.auth.currentSession;

  @override
  Future<UserModel> singUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
      try{
        final response = await supabaseClient.auth.signUp(
          email: email, 
          password: password,
          data: {
            'name': name,
          },
        );
          if(response.user == null){ 
            throw const ServerException('User is null');
          }
          return UserModel.fromJson(response.user!.toJson());
      } catch (e) {
        throw ServerException(e.toString());
      }
    }

  @override
  Future<UserModel> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try{
      final response = await supabaseClient.auth.signInWithPassword(
        email: email, 
        password: password,
      );
      if(response.user == null){ 
        throw const ServerException('User is null');
      }
      return UserModel.fromJson(response.user!.toJson());
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
  
  @override
  Future<UserModel?> getCurrentUserData() async{
    try{
      if (currentUserSession!=null) {
        final userData = await supabaseClient.from('profiles').select().eq(
          'id', 
          currentUserSession!.user.id,
        );
        return UserModel.fromJson(userData.first).copyWith(
          email: currentUserSession!.user.email,
        );
      }
      
      return null;
    }catch(e){
      throw ServerException(e.toString());
    }
  }
}