import 'package:dartz/dartz.dart';

import '../../../core/core.dart';
import '../../domain.dart';

class GetRemoteUserUsecase implements UseCase<User, NoParams> {
  final UserRepository repository;
  GetRemoteUserUsecase(this.repository);

  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return await repository.getRemoteUser();
  }
}
