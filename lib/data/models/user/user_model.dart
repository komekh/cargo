import 'dart:convert';

import '../../../domain/entities/user/user.dart';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel extends User {
  const UserModel({
    required super.oid,
    required super.fullName,
    required super.phone,
  });

  factory UserModel.fromUser(User user) {
    return UserModel(
      oid: user.oid,
      fullName: user.fullName,
      phone: user.phone,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        oid: json['Oid'],
        fullName: json['FullName'],
        phone: json['PhoneNo'],
      );

  Map<String, dynamic> toJson() => {
        'Oid': oid,
        'FullName': fullName,
        'PhoneNo': phone,
      };
}
