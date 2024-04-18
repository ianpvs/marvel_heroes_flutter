class HeroEntity {
  late int id;
  late String name;
  late String description;
  late String thumbnailPath;

  HeroEntity(
      {required this.id,
      required this.name,
      required this.description,
      required this.thumbnailPath});

  factory HeroEntity.fromJson(Map<String, dynamic> json) {
    return HeroEntity(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      thumbnailPath:
          json['thumbnail']['path'] + '.' + json['thumbnail']['extension'],
    );
  }
}
