import 'dart:convert';

import '../../../domain/entities/entities.dart';
import 'contact_model.dart';

ContactResponseModel contactResponseModelFromJson(String str) => ContactResponseModel.fromJson(json.decode(str));

class ContactResponseModel extends ContactResponse {
  ContactResponseModel({required super.contacts});

  factory ContactResponseModel.fromJson(Map<String, dynamic> json) {
    return ContactResponseModel(
      contacts: List<ContactModel>.from(
        json['value'].map((contact) => ContactModel.fromJson(contact)),
      ),
    );
  }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'value': contacts.map((contact) => contact.toJson()).toList(),
  //   };
  // }
}
