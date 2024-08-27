import 'package:http/http.dart' as http;

import '../../../core/core.dart';
import '../../../domain/domain.dart';
import '../../data.dart';
import '../../models/route/route_response_model.dart';

abstract class OrderRemoteDataSource {
  Future<OrderResponseModel> getOrders(FilterProductParams params, String token);
  Future<RouteResponseModel> getRoutes(String orderId);
}

class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  final http.Client client;
  OrderRemoteDataSourceImpl({required this.client});

  @override
  Future<OrderResponseModel> getOrders(FilterProductParams params, String token) async {
    Uri uri = Uri.parse(
      '$baseUrl/Goods?pageNumber=${params.offset}&pageSize=${params.limit}${params.state != null ? '&state=${params.state!.name}' : ''}',
    );

    final response = await client.get(
      uri,
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

  @override
  Future<RouteResponseModel> getRoutes(String cargoId) async {
    final response = await client.get(
      Uri.parse('$baseUrl/Cargo/Route/$cargoId'),
      headers: {
        'Content-Type': 'application/json',
        'accept': '*/*',
      },
    );

    if (response.statusCode == 200) {
      return routeResponseModelFromJson(response.body);
    } else {
      throw ServerException();
    }
  }
}
