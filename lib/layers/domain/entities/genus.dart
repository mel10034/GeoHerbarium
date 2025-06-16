// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

class Ccategory {
  int id;
  String created_at;
  String name;
  Ccategory({
    required this.id,
    required this.created_at,
    required this.name,
  });
 

  Ccategory copyWith({
    int? id,
    String? created_at,
    String? name,
  }) {
    return Ccategory(
      id: id ?? this.id,
      created_at: created_at ?? this.created_at,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'created_at': created_at,
      'name': name,
    };
  }

  factory Ccategory.fromMap(Map<String, dynamic> map) {
    return Ccategory(
      id: map['id'] as int,
      created_at: map['created_at'] as String,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Ccategory.fromJson(String source) => Ccategory.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Ccategory(id: $id, created_at: $created_at, name: $name)';

  @override
  bool operator ==(covariant Ccategory other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.created_at == created_at &&
      other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ created_at.hashCode ^ name.hashCode;
}
