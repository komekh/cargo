import '../../../domain/entities/contact/contact.dart';

class ContactModel extends ContactEntity {
  ContactModel({
    required super.oid,
    required super.number,
    required super.name,
  });

  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
      oid: json['Oid'],
      number: json['Number'],
      name: json['Name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Oid': oid,
      'Number': number,
      'Name': name,
    };
  }
}
