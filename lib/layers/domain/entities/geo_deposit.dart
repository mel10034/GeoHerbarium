import 'dart:convert';


// ignore_for_file: public_member_api_docs, sort_constructors_first
class GeoDeposit {
  int id;
  String name;
  String description;
  String image;
  String icon_uri;
  int latitude;
  int longitude;

  GeoDeposit({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.icon_uri,
    required this.latitude,
    required this.longitude,
  });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'image': image,
      'icon_uri': icon_uri,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory GeoDeposit.fromMap(Map<String, dynamic> map) {
    return GeoDeposit(
      id: map['id'] as int,
      name: map['name'] as String,
      description: map['description'] as String,
      image: map['image'] as String,
      icon_uri: map['icon_uri'] as String,
      latitude: map['latitude'] as int,
      longitude: map['longitude'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory GeoDeposit.fromJson(String source) => GeoDeposit.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant GeoDeposit other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.description == description &&
      other.image == image &&
      other.icon_uri == icon_uri &&
      other.latitude == latitude &&
      other.longitude == longitude;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      description.hashCode ^
      image.hashCode ^
      icon_uri.hashCode ^
      latitude.hashCode ^
      longitude.hashCode;
  }
}
