part of 'pond_bloc.dart';

@immutable
sealed class PondEvent{}

final class PondUpload extends PondEvent{
  final String userID;
  final String name;
  final int area;
  final int deep;
  final int costs;
  final int active;
  final File image;
  final List<String> topics;
  PondUpload({
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

final class PondFetchAllPonds extends PondEvent{}