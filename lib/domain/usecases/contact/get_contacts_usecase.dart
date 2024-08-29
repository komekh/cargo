import 'package:dartz/dartz.dart';

import '../../../core/core.dart';
import '../../domain.dart';

class GetContactsUseCase implements UseCase<ContactResponse, NoParams> {
  final ContactRepository repository;
  GetContactsUseCase(this.repository);

  @override
  Future<Either<Failure, ContactResponse>> call(NoParams params) async {
    return await repository.getContacts();
  }
}
