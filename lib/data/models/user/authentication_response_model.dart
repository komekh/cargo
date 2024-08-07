// import 'dart:convert';

// import 'user_model.dart';

// AuthenticationResponseModel authenticationResponseModelFromJson(String str) =>
//     AuthenticationResponseModel.fromJson(json.decode(str));

// String authenticationResponseModelToJson(AuthenticationResponseModel data) => json.encode(data.toJson());

// class AuthenticationResponseModel {
//   final String token;
//   final UserModel user;

//   const AuthenticationResponseModel({
//     required this.token,
//     required this.user,
//   });

//   factory AuthenticationResponseModel.fromJson(Map<String, dynamic> json) => AuthenticationResponseModel(
//         token: json['token'],
//         user: UserModel.fromJson(json['user']),
//       );

//   Map<String, dynamic> toJson() => {
//         'token': token,
//         'user': user.toJson(),
//       };

//   AuthenticationResponseModel copyWith({
//     String? token,
//     UserModel? user,
//   }) {
//     return AuthenticationResponseModel(
//       token: token ?? this.token,
//       user: user ?? this.user,
//     );
//   }
// }
