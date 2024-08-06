import 'package:dartz/dartz.dart';

import '../../core/core.dart';
import '../../domain/domain.dart';
import '../data.dart';

class SplashRepositoryImpl implements SplashRepository {
  final UserLocalDataSource localDataSource;

  SplashRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, bool>> isTokenAvailable() async {
    try {
      final isAvl = await localDataSource.isTokenAvailable();
      return Right(isAvl);
    } on CacheFailure {
      return Left(CacheFailure());
    }
  }
}
