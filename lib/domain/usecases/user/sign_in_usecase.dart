import 'package:dartz/dartz.dart';

import '../../../core/core.dart';
import '../../domain.dart';

class SignInUseCase implements UseCase<String, SignInParams> {
  final UserRepository repository;
  SignInUseCase(this.repository);

  @override
  Future<Either<Failure, String>> call(SignInParams params) async {
    return await repository.signIn(params);
  }
}

class SignInParams {
  final String username;
  final String password;
  const SignInParams({
    required this.username,
    required this.password,
  });
}
