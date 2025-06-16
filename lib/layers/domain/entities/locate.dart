// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:geolog/layers/domain/entities/geo_point.dart';

class Locate {
  int id;
  String region;
  String country;
  String description;
  GeoPoint? geo_point;
  GeoPoint? geo_polygon;
  int plant_id;
  Locate({
    required this.id,
    required this.region,
    required this.country,
    required this.description,
    this.geo_point,
    this.geo_polygon,
    required this.plant_id,
  });


  Locate copyWith({
    int? id,
    String? region,
    String? country,
    String? description,
    GeoPoint? geo_point,
    GeoPoint? geo_polygon,
    int? plant_id,
  }) {
    return Locate(
      id: id ?? this.id,
      region: region ?? this.region,
      country: country ?? this.country,
      description: description ?? this.description,
      geo_point: geo_point ?? this.geo_point,
      geo_polygon: geo_polygon ?? this.geo_polygon,
      plant_id: plant_id ?? this.plant_id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'region': region,
      'country': country,
      'description': description,
      'geo_point': geo_point?.toMap(),
      'geo_polygon': geo_polygon?.toMap(),
      'plant_id': plant_id,
    };
  }

  factory Locate.fromMap(Map<String, dynamic> map) {
    return Locate(
      id: map['id'] as int,
      region: map['region'] as String,
      country: map['country'] as String,
      description: map['description'] as String,
      geo_point: map['geo_point'] != null ? GeoPoint.fromMap(map['geo_point'] as Map<String,dynamic>) : null,
      geo_polygon: map['geo_polygon'] != null ? GeoPoint.fromMap(map['geo_polygon'] as Map<String,dynamic>) : null,
      plant_id: map['plant_id'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Locate.fromJson(String source) => Locate.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Locate(id: $id, region: $region, country: $country, description: $description, geo_point: $geo_point, geo_polygon: $geo_polygon, plant_id: $plant_id)';
  }

  @override
  bool operator ==(covariant Locate other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.region == region &&
      other.country == country &&
      other.description == description &&
      other.geo_point == geo_point &&
      other.geo_polygon == geo_polygon &&
      other.plant_id == plant_id;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      region.hashCode ^
      country.hashCode ^
      description.hashCode ^
      geo_point.hashCode ^
      geo_polygon.hashCode ^
      plant_id.hashCode;
  }
}
