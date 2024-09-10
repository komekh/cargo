import 'package:dartz/dartz.dart';

import '../../core/core.dart';
import '../../domain/domain.dart';
import '../data.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;
  final UserLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  UserRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, String>> signIn(params) async {
    if (await networkInfo.isConnected) {
      try {
        /// login
        final token = await remoteDataSource.signIn(params);
        await localDataSource.saveToken(token);

        /// get FB token
        final String? fcmToken = await fcmFunctions.getFCMToken();
        if (fcmToken != null) {
          await remoteDataSource.registerFBToken(token, fcmToken);
        }

        return Right(token);
      } on Failure catch (failure) {
        return Left(failure);
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, User>> getCachedUser() async {
    try {
      final user = await localDataSource.getUser();
      return Right(user);
    } on CacheFailure {
      return Left(CacheFailure());
    } catch (error) {
      return Left(ExceptionFailure());
    }
  }

  @override
  Future<Either<Failure, NoParams>> signOut() async {
    try {
      await localDataSource.clearCache();
      return Right(NoParams());
    } on CacheFailure {
      return Left(CacheFailure());
    } catch (error) {
      return Left(ExceptionFailure());
    }
  }

  @override
  Future<Either<Failure, User>> getRemoteUser() async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure());
    }

    if (!await localDataSource.isTokenAvailable()) {
      return Left(AuthenticationFailure());
    }

    try {
      final String token = await localDataSource.getToken();
      final user = await remoteDataSource.getUser(token);
      await localDataSource.saveUser(UserModel.fromUser(user));
      return Right(user);
    } on Failure catch (failure) {
      return Left(failure);
    } catch (error) {
      return Left(ExceptionFailure());
    }
  }
}
