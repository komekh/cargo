import 'package:dartz/dartz.dart';

import '../../../core/core.dart';
import '../../domain.dart';

class DeleteAccountUseCase implements UseCase<int, NoParams> {
  final UserRepository repository;
  DeleteAccountUseCase(this.repository);

  @override
  Future<Either<Failure, int>> call(NoParams params) async {
    return await repository.deleteAccount();
  }
}
