import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../core/core.dart';
import '../../../domain/domain.dart';
import '../../data.dart';

abstract class OrderRemoteDataSource {
  Future<List<OrderModel>> getOrders(FilterProductParams params, String token);
}

class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  final http.Client client;
  OrderRemoteDataSourceImpl({required this.client});

  @override
  Future<List<OrderModel>> getOrders(FilterProductParams params, String token) async {
    final response = await client.get(
      Uri.parse('$baseUrl/Goods'),
      headers: {
        'Content-Type': 'application/json',
        'accept': '*/*',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      final list = jsonData.map((item) => OrderModel.fromJson(item)).toList();
      return list;
    } else {
      throw ServerException();
    }
  }
}
