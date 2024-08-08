import 'package:dartz/dartz.dart';

import '../../core/errors/failures.dart';
import '../domain.dart';

abstract class OrderRepository {
  Future<Either<Failure, List<OrderEntity>>> getOrders(FilterProductParams params);
}
