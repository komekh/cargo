import 'package:dartz/dartz.dart';

import '../../../core/core.dart';
import '../../domain.dart';

class GetCachedUserUseCase implements UseCase<User, NoParams> {
  final UserRepository repository;
  GetCachedUserUseCase(this.repository);

  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return await repository.getCachedUser();
  }
}
