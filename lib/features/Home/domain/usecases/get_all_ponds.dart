import 'package:fpdart/fpdart.dart';
import 'package:namer_app/core/error/failures.dart';
import 'package:namer_app/core/usecase/usecase.dart';
import 'package:namer_app/features/Home/domain/entities/pond.dart';
import 'package:namer_app/features/Home/domain/repositories/pond_repository.dart';

class GetAllPonds implements UseCase<List<Pond>,NoParams>{
  final PondRepository pondRepository;
  GetAllPonds(this.pondRepository);
  
  @override
  Future<Either<Failure, List<Pond>>> call(NoParams params) async{
    return await pondRepository.getAllPonds();
  }   
}