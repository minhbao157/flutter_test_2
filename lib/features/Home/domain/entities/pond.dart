class Pond {
  final String id;
  final String userId;
  final String name;
  final String imageUrl;
  final int area;
  final int deep;
  final int costs;
  final int active;
  final List<String> topics;
  final DateTime updatedAt;

  Pond({
    required this.id, 
    required this.userId, 
    required this.name, required this.imageUrl, 
    required this.area, required this.deep, 
    required this.costs, required this.active, 
    required this.topics, required this.updatedAt,
  });
}
