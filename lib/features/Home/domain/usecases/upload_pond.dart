// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/pond.dart';
import '../repositories/pond_repository.dart';

class UploadPond implements UseCase<Pond, UploadPondParams>{
  final PondRepository pondRepository;
  UploadPond(this.pondRepository);

  @override
  Future<Either<Failure, Pond>> call(UploadPondParams params) async {
    return await pondRepository.uploadPond(
      image: params.image, 
      userId: params.userID, 
      name: params.name, 
      area: params.area, 
      deep: params.deep, 
      costs: params.costs, 
      active: params.active, 
      topics: params.topics,
      
    );
  }

}

class UploadPondParams {
  final String userID;
  final String name;
  final int area;
  final int deep;
  final int costs;
  final int active;
  final File image;
  final List<String> topics;
  UploadPondParams({
    required this.userID,
    required this.name,
    required this.area,
    required this.deep,
    required this.costs,
    required this.active,
    required this.image,
    required this.topics,
  });
}
