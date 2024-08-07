import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String oid;
  final String fullName;
  final String phone;

  const User({
    required this.oid,
    required this.fullName,
    required this.phone,
  });

  @override
  List<Object> get props => [
        oid,
        fullName,
        phone,
      ];
}
