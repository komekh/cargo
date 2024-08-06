import 'package:dartz/dartz.dart';

import '../../../core/core.dart';
import '../../domain.dart';

class SplashUseCase implements UseCase<bool, NoParams> {
  final SplashRepository repository;
  SplashUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return await repository.isTokenAvailable();
  }
}
