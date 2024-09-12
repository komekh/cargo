import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import '../../../core/core.dart';
import '../../../domain/domain.dart';
import '../../data.dart';

abstract class UserRemoteDataSource {
  Future<String> signIn(SignInParams params);
  Future<int> signUp(SignUpParams params);
  Future<int> deleteAccount(String token);
  Future<User> getUser(String token);
  Future<void> registerFBToken(String token, String fbToken);
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
          'UserName': params.username.trim(),
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
  Future<int> signUp(SignUpParams params) async {
    final response = await client.post(
      Uri.parse('$baseUrl/Client/Register'),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'accept': '*/*',
      },
      body: {
        'username': params.username.trim(),
        'password': params.password,
      },
    );

    return response.statusCode;
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

  @override
  Future<void> registerFBToken(String token, String fbToken) async {
    /* final response = */
    await client.post(
      Uri.parse('$baseUrl/Client/FirebaseToken?token=$fbToken'),
      headers: {
        'accept': '*/*',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    /* if (response.statusCode != 200) {
      throw ServerException();
    } */
  }

  @override
  Future<int> deleteAccount(String token) async {
    final response = await client.delete(
      Uri.parse('$baseUrl/Client/DeleteAccount'),
      headers: {
        'accept': '*/*',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    debugPrint(response.body);

    return response.statusCode;
  }
}
