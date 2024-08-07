import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../core/core.dart';
import '../../../domain/domain.dart';
import '../../data.dart';

abstract class UserRemoteDataSource {
  Future<String> signIn(SignInParams params);
  Future<User> getUser(String token);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final http.Client client;
  UserRemoteDataSourceImpl({required this.client});

  @override
  Future<String> signIn(SignInParams params) async {
    final response = await client.post(
      Uri.parse('$baseUrl/Authentication/Authenticate'),
      headers: {
        'Content-Type': 'application/json',
        'accept': '*/*',
      },
      body: json.encode(
        {
          'UserName': params.username,
          'Password': params.password,
        },
      ),
    );

    if (response.statusCode == 200) {
      return response.body;
    } else if (response.statusCode == 400 || response.statusCode == 401) {
      throw CredentialFailure();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<User> getUser(String token) async {
    final response = await client.get(
      Uri.parse('$baseUrl/Client/GetClient'),
      headers: {
        'Content-Type': 'application/json',
        'accept': '*/*',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final user = UserModel.fromJson(json.decode(response.body));
      return user;
    } else {
      throw ServerException();
    }
  }
}
