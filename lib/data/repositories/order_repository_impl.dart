import 'package:cargo/data/models/route/route_response_model.dart';
import 'package:dartz/dartz.dart';

import '../../core/core.dart';
import '../../domain/domain.dart';
import '../data_sources/data_sources.dart';
import '../models/order/order_response_model.dart';

class OrderRepositoryImpl extends OrderRepository {
  final OrderRemoteDataSource remoteDataSource;
  final UserLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  OrderRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, OrderResponseModel>> getOrders(FilterProductParams params) async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure());
    }

    if (!await localDataSource.isTokenAvailable()) {
      return Left(AuthenticationFailure());
    }

    try {
      final String token = await localDataSource.getToken();
      final response = await remoteDataSource.getOrders(params, token);
      return Right(response);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, RouteResponseModel>> getRoutes(String cargoId) async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure());
    }

    try {
      final response = await remoteDataSource.getRoutes(cargoId);
      return Right(response);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }
}
