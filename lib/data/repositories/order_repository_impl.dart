import 'package:dartz/dartz.dart';

import '../../core/core.dart';
import '../../domain/domain.dart';
import '../data_sources/data_sources.dart';

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
  Future<Either<Failure, List<OrderEntity>>> getOrders(FilterProductParams params) async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure());
    }

    if (!await localDataSource.isTokenAvailable()) {
      return Left(AuthenticationFailure());
    }

    try {
      final String token = await localDataSource.getToken();
      final orders = await remoteDataSource.getOrders(params, token);
      return Right(orders);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }
}
