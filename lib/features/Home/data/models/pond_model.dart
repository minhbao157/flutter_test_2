import 'package:namer_app/features/Home/domain/entities/pond.dart';

class PondModel extends Pond{
  PondModel({
    required super.id, 
    required super.userId, 
    required super.name, 
    required super.imageUrl, 
    required super.area, 
    required super.deep, 
    required super.costs, 
    required super.active, 
    required super.topics, 
    required super.updatedAt,
  });

  
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'user_id': userId,
      'name': name,
      'image_url': imageUrl,
      'area': area,
      'deep': deep,
      'costs': costs,
      'active': active,
      'topics': topics,
      'updated_at': updatedAt.toIso8601String() ,
    };
  }

  factory PondModel.fromJson(Map<String, dynamic> map) {
    return PondModel(
      id: map['id'] as String,
      userId: map['user_id'] as String,
      name: map['name'] as String,
      imageUrl: map['image_url'] as String,
      area: map['area'] as int,
      deep: map['deep'] as int,
      costs: map['costs'] as int,
      active: map['active'] as int,
      topics: List<String>.from(map['topics'] ?? []),
      updatedAt: map ['updated_at'] == null
      ? DateTime.now()
      :DateTime.parse(map['updated_at']),
    );
  }

  PondModel copyWith({
    String? id,
    String? userId,
    String? name,
    String? imageUrl,
    int? area,
    int? deep,
    int? costs,
    int? active,
    List<String>? topics,
    DateTime? updatedAt,
  }) {
    return PondModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      area: area ?? this.area,
      deep: deep ?? this.deep,
      costs: costs ?? this.costs,
      active: active ?? this.active,
      topics: topics ?? this.topics,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}