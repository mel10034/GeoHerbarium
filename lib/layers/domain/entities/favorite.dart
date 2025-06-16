// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Favorite {
  int id;
  int plant_id;
  String created_at;
  String user_id;
  Favorite({
    required this.id,
    required this.plant_id,
    required this.created_at,
    required this.user_id,
  });

  

  Favorite copyWith({
    int? id,
    int? plant_id,
    String? created_at,
    String? user_id,
  }) {
    return Favorite(
      id: id ?? this.id,
      plant_id: plant_id ?? this.plant_id,
      created_at: created_at ?? this.created_at,
      user_id: user_id ?? this.user_id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'plant_id': plant_id,
      'created_at': created_at,
      'user_id': user_id,
    };
  }

  factory Favorite.fromMap(Map<String, dynamic> map) {
    return Favorite(
      id: map['id'] as int,
      plant_id: map['plant_id'] as int,
      created_at: map['created_at'] as String,
      user_id: map['user_id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Favorite.fromJson(String source) => Favorite.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Favorite(id: $id, plant_id: $plant_id, created_at: $created_at, user_id: $user_id)';
  }

  @override
  bool operator ==(covariant Favorite other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.plant_id == plant_id &&
      other.created_at == created_at &&
      other.user_id == user_id;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      plant_id.hashCode ^
      created_at.hashCode ^
      user_id.hashCode;
  }
}
