import 'dart:io';

import 'package:namer_app/core/error/exceptions.dart';
import 'package:namer_app/features/Home/data/models/pond_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class PondRemoteDataSource {
  Future<PondModel> uploadPond(PondModel pond);
  Future<String> uploadPondImage({
    required File image,
    required PondModel pond,
  });
  Future<List<PondModel>> getAllPonds();
}

class PondRemoteDataSourceImpl implements PondRemoteDataSource {
  final SupabaseClient supabaseClient;
  PondRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<PondModel> uploadPond(PondModel pond) async {
    try{
      final pondData = await supabaseClient.from('ponds').insert(pond.toJson()).select();
    
      return PondModel.fromJson(pondData.first); 
    }catch(e){
      throw ServerException(e.toString());
    }
  }
  
  @override
  Future<String> uploadPondImage({
    required File image, 
    required PondModel pond,
  }) async {
    try{
      await supabaseClient.storage.from('pond_images').upload(
        pond.id, 
        image,
      );
      return supabaseClient.storage.from('pond_images').getPublicUrl(
        pond.id
      );  
    }catch(e){
      throw ServerException(e.toString());
    }
  }
  
  @override
  Future<List<PondModel>> getAllPonds() async{
    try{
      final ponds = await supabaseClient.from('ponds').select('*, profiles (*)');
      return ponds.map((pond) => PondModel.fromJson(pond)).toList();
    }catch(e){
      throw ServerException(e.toString());
    }
  }
  
}