class Category {
  Category({
    required this.name,
    required this.type,
  });

  String name;
  String type;
  bool isSelected = false;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        name: json["name"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "type": type,
      };
}
