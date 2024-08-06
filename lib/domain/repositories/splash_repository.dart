import 'package:dartz/dartz.dart';

import '../../core/core.dart';

abstract class SplashRepository {
  Future<Either<Failure, bool>> isTokenAvailable();
}
