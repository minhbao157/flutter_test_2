part of 'pond_bloc.dart';

@immutable
sealed class PondState{}

final class PondInitial extends PondState {}

final class PondLoading extends PondState{}

final class PondFailure extends PondState{
  final String error;
  PondFailure(this.error);
}

final class PondUploadSuccess extends PondState{}

final class PondDisplaySuccess extends PondState{
  final List<Pond> ponds;
  PondDisplaySuccess(this.ponds);
}