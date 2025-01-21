import 'dart:io';
import 'package:fpdart/fpdart.dart';
import 'package:namer_app/features/Home/data/models/datasources/pond_remote_data_source.dart';
import 'package:namer_app/features/Home/data/models/pond_model.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/pond.dart';
import '../../domain/repositories/pond_repository.dart';

class PondRepositoryImp implements PondRepository{
  final PondRemoteDataSource pondRemoteDataSource;
  PondRepositoryImp(this.pondRemoteDataSource);

  @override
  Future<Either<Failure, Pond>> uploadPond({
    required File image, 
    required String userId, 
    required String name, 
    required int area, 
    required int deep, 
    required int costs, 
    required int active, 
    required List<String> topics,
    }) async{
      try{
        PondModel pondModel = PondModel(
          id: const Uuid().v1(), 
          userId: userId, 
          name: name, 
          imageUrl: '', 
          area: area, 
          deep: deep, 
          costs: costs, 
          active: active, 
          topics: topics, 
          updatedAt: DateTime.now(),
        );

        final imageUrl = await pondRemoteDataSource.uploadPondImage(
          image: image, 
          pond: pondModel,
        );

        pondModel = pondModel.copyWith(
          imageUrl: imageUrl,
        );

        final uploadedPond = await pondRemoteDataSource.uploadPond(pondModel); 
        return right(uploadedPond);
      } on ServerException catch(e){
        return left(Failure(e.message));
      }
  }
  
  @override
  Future<Either<Failure, List<Pond>>> getAllPonds() async{
    try{
      final ponds = await pondRemoteDataSource.getAllPonds();

      return right(ponds);
    } on ServerException catch(e){
      return left(Failure(e.toString()));
    }
  }
  
}