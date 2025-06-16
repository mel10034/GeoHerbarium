// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class GeoPoint {
  String type;
  List<dynamic> coordinates;
  GeoPoint({
    required this.type,
    required this.coordinates,
  });
 

  GeoPoint copyWith({
    String? type,
    List<dynamic>? coordinates,
  }) {
    return GeoPoint(
      type: type ?? this.type,
      coordinates: coordinates ?? this.coordinates,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'type': type,
      'coordinates': coordinates,
    };
  }

  factory GeoPoint.fromMap(Map<String, dynamic> map) {
    return GeoPoint(
      type: map['type'] as String,
      coordinates: map['coordinates'] as List<dynamic>,
    );
  }

  String toJson() => json.encode(toMap());

  factory GeoPoint.fromJson(String source) => GeoPoint.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'GeoPoint(type: $type, coordinates: $coordinates)';

  @override
  bool operator ==(covariant GeoPoint other) {
    if (identical(this, other)) return true;
  
    return 
      other.type == type &&
      listEquals(other.coordinates, coordinates);
  }

  @override
  int get hashCode => type.hashCode ^ coordinates.hashCode;
}
