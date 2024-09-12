import 'package:dartz/dartz.dart';

import '../../../core/core.dart';
import '../../domain.dart';

class SignUpUseCase implements UseCase<int, SignUpParams> {
  final UserRepository repository;
  SignUpUseCase(this.repository);

  @override
  Future<Either<Failure, int>> call(SignUpParams params) async {
    return await repository.signUp(params);
  }
}

class SignUpParams {
  // final String firstName;
  // final String lastName;
  final String username;
  final String password;
  const SignUpParams({
    // required this.firstName,
    // required this.lastName,
    required this.username,
    required this.password,
  });
}
