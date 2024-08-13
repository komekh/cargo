import 'package:http/http.dart' as http;

import '../../../core/core.dart';
import '../../../domain/domain.dart';
import '../../data.dart';

abstract class OrderRemoteDataSource {
  Future<OrderResponseModel> getOrders(FilterProductParams params, String token);
}

class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  final http.Client client;
  OrderRemoteDataSourceImpl({required this.client});

  @override
  Future<OrderResponseModel> getOrders(FilterProductParams params, String token) async {
    final response = await client.get(
      Uri.parse('$baseUrl/Goods?pageNumber=${params.offset}&pageSize=${params.limit}'),
      headers: {
        'Content-Type': 'application/json',
        'accept': '*/*',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return orderResponseModelFromJson(response.body);
    } else {
      throw ServerException();
    }
  }
}
