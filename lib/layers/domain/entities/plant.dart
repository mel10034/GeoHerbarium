// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Plant {
  int id;
  String created_at;
  String model;
  String name_ru;
  String description;
  String name_latin;
  int? family;
  int? genus;
  int? plant_type;
  int? life_cycle;
  int? habitat;
  String source;
  String origin;
  String created_by;
  String image;
  Plant({
    required this.id,
    required this.created_at,
    required this.model,
    required this.name_ru,
    required this.description,
    required this.name_latin,
    this.family,
    this.genus,
    this.plant_type,
    this.life_cycle,
    this.habitat,
    required this.source,
    required this.origin,
    required this.created_by,
    required this.image,
  });


  Plant copyWith({
    int? id,
    String? created_at,
    String? model,
    String? name_ru,
    String? description,
    String? name_latin,
    int? family,
    int? genus,
    int? plant_type,
    int? life_cycle,
    int? habitat,
    String? source,
    String? origin,
    String? created_by,
    String? image,
  }) {
    return Plant(
      id: id ?? this.id,
      created_at: created_at ?? this.created_at,
      model: model ?? this.model,
      name_ru: name_ru ?? this.name_ru,
      description: description ?? this.description,
      name_latin: name_latin ?? this.name_latin,
      family: family ?? this.family,
      genus: genus ?? this.genus,
      plant_type: plant_type ?? this.plant_type,
      life_cycle: life_cycle ?? this.life_cycle,
      habitat: habitat ?? this.habitat,
      source: source ?? this.source,
      origin: origin ?? this.origin,
      created_by: created_by ?? this.created_by,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'created_at': created_at,
      'model': model,
      'name_ru': name_ru,
      'description': description,
      'name_latin': name_latin,
      'family': family,
      'genus': genus,
      'plant_type': plant_type,
      'life_cycle': life_cycle,
      'habitat': habitat,
      'source': source,
      'origin': origin,
      'created_by': created_by,
      'image': image,
    };
  }

  factory Plant.fromMap(Map<String, dynamic> map) {
    return Plant(
      id: map['id'] as int,
      created_at: map['created_at'] as String,
      model: map['model'] as String,
      name_ru: map['name_ru'] as String,
      description: map['description'] as String,
      name_latin: map['name_latin'] as String,
      family: map['family'] != null ? map['family'] as int : null,
      genus: map['genus'] != null ? map['genus'] as int : null,
      plant_type: map['plant_type'] != null ? map['plant_type'] as int : null,
      life_cycle: map['life_cycle'] != null ? map['life_cycle'] as int : null,
      habitat: map['habitat'] != null ? map['habitat'] as int : null,
      source: map['source'] as String,
      origin: map['origin'] as String,
      created_by: map['created_by'] as String,
      image: map['image'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Plant.fromJson(String source) => Plant.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Plant(id: $id, created_at: $created_at, model: $model, name_ru: $name_ru, description: $description, name_latin: $name_latin, family: $family, genus: $genus, plant_type: $plant_type, life_cycle: $life_cycle, habitat: $habitat, source: $source, origin: $origin, created_by: $created_by, image: $image)';
  }

  @override
  bool operator ==(covariant Plant other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.created_at == created_at &&
      other.model == model &&
      other.name_ru == name_ru &&
      other.description == description &&
      other.name_latin == name_latin &&
      other.family == family &&
      other.genus == genus &&
      other.plant_type == plant_type &&
      other.life_cycle == life_cycle &&
      other.habitat == habitat &&
      other.source == source &&
      other.origin == origin &&
      other.created_by == created_by &&
      other.image == image;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      created_at.hashCode ^
      model.hashCode ^
      name_ru.hashCode ^
      description.hashCode ^
      name_latin.hashCode ^
      family.hashCode ^
      genus.hashCode ^
      plant_type.hashCode ^
      life_cycle.hashCode ^
      habitat.hashCode ^
      source.hashCode ^
      origin.hashCode ^
      created_by.hashCode ^
      image.hashCode;
  }
}
