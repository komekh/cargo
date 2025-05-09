import 'package:dartz/dartz.dart';

import '../../core/core.dart';
import '../domain.dart';

abstract class UserRepository {
  Future<Either<Failure, String>> signIn(SignInParams params);
  Future<Either<Failure, int>> signUp(SignUpParams params);
  Future<Either<Failure, NoParams>> signOut();
  Future<Either<Failure, int>> deleteAccount();
  Future<Either<Failure, User>> getCachedUser();
  Future<Either<Failure, User>> getRemoteUser();
}
