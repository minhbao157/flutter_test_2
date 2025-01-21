import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:namer_app/core/usecase/usecase.dart';
import 'package:namer_app/features/Home/domain/entities/pond.dart';
import 'package:namer_app/features/Home/domain/usecases/get_all_ponds.dart';
import 'package:namer_app/features/Home/domain/usecases/upload_pond.dart';
part 'pond_event.dart';
part 'pond_state.dart';

class PondBloc extends Bloc<PondEvent, PondState> {
  final UploadPond _uploadPond;
  final GetAllPonds _getAllPonds;
  PondBloc({
    required UploadPond uploadPond,
    required GetAllPonds getAllPonds,
  }) : _uploadPond = uploadPond,
       _getAllPonds = getAllPonds, 
  super(PondInitial()) {
    on<PondEvent>((event, emit) => emit(PondLoading()));
    on<PondUpload>(_onPondUpload);
    on<PondFetchAllPonds>(_onFetchAllPonds);
  }

  void _onPondUpload(
    PondUpload event, 
    Emitter<PondState> emit,
  ) async{
    final res = await _uploadPond(
      UploadPondParams(
        userID: event.userID, 
        name: event.name, 
        area: event.area, 
        deep: event.deep, 
        costs: event.costs, 
        active: event.active, 
        image: event.image, 
        topics: event.topics,
      ),
    );

    res.fold(
      (l) => emit(PondFailure(l.message)), 
      (r) => emit(PondUploadSuccess()),
    );
  }

  void _onFetchAllPonds(
    PondFetchAllPonds event, 
    Emitter<PondState> emit,
  )async{
    final res = await _getAllPonds(NoParams());
  
    res.fold(
      (l) => emit(PondFailure(l.message)), 
      (r) => emit(PondDisplaySuccess(r)), 
    );
  }
}
