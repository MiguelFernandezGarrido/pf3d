import 'dart:convert';

class Model {
  String? id = '';
  String src = '';
  String name = '';
  bool isFavorite = false;
  bool isActive = false;

  Model({
    this.id,
    required this.src,
    required this.name,
    this.isFavorite = false,
    this.isActive = false,
  });

  factory Model.fromJson(Map<String, dynamic> json) {
    return Model(
      id: json['id'],
      isActive: json['isActive'],
      name: json['name'],
      src: json['src'],
      isFavorite: true,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'src': src, 'name': name, 'isActive': isActive};
  }
}

List<Model> modelsFromJson(String jsonData) {
  final List<dynamic> data = json.decode(jsonData);
  final List<Model> models = [];
  for (var item in data) {
    models.add(Model.fromJson(item));
  }
  return models;
  // Map<String, dynamic> data = json.decode(jsonData);
  // return data.entries.map((e) => Model.fromJson(e.value)).toList();
}

String modelsToJson(List<Model> data) {
  List<Model> models = [];
  for (Model element in data) {
    models.add(Model.fromJson(element.toJson()));
  }
  return json.encode(models);
}
