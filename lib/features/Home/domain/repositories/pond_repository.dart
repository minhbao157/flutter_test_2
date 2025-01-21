import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:namer_app/core/error/failures.dart';
import 'package:namer_app/features/Home/domain/entities/pond.dart';

abstract interface class PondRepository {
  Future<Either<Failure, Pond>> uploadPond({
    required File image,
    required String userId,
    required String name,
    required int area,
    required int deep,
    required int costs,
    required int active,
    required List<String> topics,
  });

  Future<Either<Failure, List <Pond>>> getAllPonds();
}