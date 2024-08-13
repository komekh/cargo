import 'package:dartz/dartz.dart';

import '../../../core/core.dart';
import '../../../data/models/order/order_response_model.dart';
import '../../domain.dart';

class GetOrderUseCase implements UseCase<OrderResponseModel, FilterProductParams> {
  final OrderRepository repository;
  GetOrderUseCase(this.repository);

  @override
  Future<Either<Failure, OrderResponseModel>> call(FilterProductParams params) async {
    return await repository.getOrders(params);
  }
}
