import 'package:dartz/dartz.dart';

import '../../../core/core.dart';
import '../../domain.dart';

class GetOrderUseCase implements UseCase<List<OrderEntity>, FilterProductParams> {
  final OrderRepository repository;
  GetOrderUseCase(this.repository);

  @override
  Future<Either<Failure, List<OrderEntity>>> call(FilterProductParams params) async {
    return await repository.getOrders(params);
  }
}
