import 'package:dartz/dartz.dart';

import '../../../core/core.dart';
import '../../../data/models/route/route_response_model.dart';
import '../../domain.dart';

class GetRoutesUseCase implements UseCase<RouteResponseModel, String> {
  final OrderRepository repository;
  GetRoutesUseCase(this.repository);

  @override
  Future<Either<Failure, RouteResponseModel>> call(String cargoId) async {
    return await repository.getRoutes(cargoId);
  }
}
