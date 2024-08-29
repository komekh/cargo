import 'package:dartz/dartz.dart';

import '../../core/core.dart';
import '../../data/models/contact/contact_response_model.dart';

abstract class ContactRepository {
  Future<Either<Failure, ContactResponseModel>> getContacts();
}
