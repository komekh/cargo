import 'package:dartz/dartz.dart';

import '../../core/errors/failures.dart';
import '../../data/models/order/order_response_model.dart';
import '../../data/models/route/route_response_model.dart';
import '../domain.dart';

abstract class OrderRepository {
  Future<Either<Failure, OrderResponseModel>> getOrders(FilterProductParams params);
  Future<Either<Failure, RouteResponseModel>> getRoutes(String cargoId);
}
