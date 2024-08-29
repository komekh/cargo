import 'package:equatable/equatable.dart';

class ContactEntity extends Equatable {
  final String oid;
  final String number;
  final String name;

  const ContactEntity({
    required this.oid,
    required this.number,
    required this.name,
  });

  @override
  List<Object?> get props => [oid, number, name];
}
