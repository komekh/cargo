import 'package:dartz/dartz.dart';

import '../../core/core.dart';
import '../../domain/domain.dart';
import '../data_sources/data_sources.dart';
import '../models/contact/contact_response_model.dart';

class ContactRepositoryImpl extends ContactRepository {
  final ContactRemoteDataSource remoteDataSource;
  final UserLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  ContactRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, ContactResponseModel>> getContacts() async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure());
    }

    try {
      final String token = await localDataSource.getToken();
      final response = await remoteDataSource.getContacts(token);
      return Right(response);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }
}
