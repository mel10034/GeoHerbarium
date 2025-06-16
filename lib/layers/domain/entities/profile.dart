// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Profile {
  String user_id;
  String fio;
  String? avatar;
  Profile({
    required this.user_id,
    required this.fio,
    required this.avatar,
  });


  Profile copyWith({
    String? user_id,
    String? fio,
    String? avatar,
  }) {
    return Profile(
      user_id: user_id ?? this.user_id,
      fio: fio ?? this.fio,
      avatar: avatar ?? this.avatar,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user_id': user_id,
      'fio': fio,
      'avatar': avatar,
    };
  }

  factory Profile.fromMap(Map<String, dynamic> map) {
    return Profile(
      user_id: map['user_id'] as String,
      fio: map['fio'] as String,
      avatar: map['avatar'] != null ? map['avatar'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Profile.fromJson(String source) => Profile.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Profile(user_id: $user_id, fio: $fio, avatar: $avatar)';

  @override
  bool operator ==(covariant Profile other) {
    if (identical(this, other)) return true;
  
    return 
      other.user_id == user_id &&
      other.fio == fio &&
      other.avatar == avatar;
  }

  @override
  int get hashCode => user_id.hashCode ^ fio.hashCode ^ avatar.hashCode;
}
