import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../core/core.dart';
import '../../../domain/domain.dart';
import '../../data.dart';

abstract class UserRemoteDataSource {
  Future<AuthenticationResponseModel> signIn(SignInParams params);
  Future<AuthenticationResponseModel> signUp(SignUpParams params);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final http.Client client;
  UserRemoteDataSourceImpl({required this.client});

  @override
  Future<AuthenticationResponseModel> signIn(SignInParams params) async {
    debugPrint('signIn');
    final response = await client.post(Uri.parse('$baseUrl/authentication/local/sign-in'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'identifier': params.username,
          'password': params.password,
        }));
    if (response.statusCode == 200) {
      return authenticationResponseModelFromJson(response.body);
    } else if (response.statusCode == 400 || response.statusCode == 401) {
      throw CredentialFailure();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<AuthenticationResponseModel> signUp(SignUpParams params) async {
    final response = await client.post(Uri.parse('$baseUrl/authentication/local/sign-up'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'firstName': params.firstName,
          'lastName': params.lastName,
          'email': params.email,
          'password': params.password,
        }));
    if (response.statusCode == 201) {
      return authenticationResponseModelFromJson(response.body);
    } else if (response.statusCode == 400 || response.statusCode == 401) {
      throw CredentialFailure();
    } else {
      throw ServerException();
    }
  }
}
