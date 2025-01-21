class AoModel {
  final String id;
  final String name;
  final String farm_name;
  final String farm_id;
  final String description;
  final String type;

  
  AoModel({
  required this.id,
  required this.name,
  required this.farm_name,
  required this.farm_id,
  required this.description,
  required this.type,  
  });

  factory AoModel.fromJSON(Map<String, dynamic> json)
  {
    return AoModel(
      id: json['id'],
      name: json['name'],
      farm_name: json['farm_name'],
      farm_id: json['farm_id'],
      description: json['decription'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson()
  {
    return{
      'id': id,
      'name': name,
      'farm_name': farm_name,
      'farm_id': farm_id,
      'description': description,
      'type': type,
    };
  }
}

