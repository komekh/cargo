import 'package:http/http.dart' as http;

import '../../../core/core.dart';
import '../../data.dart';

abstract class ContactRemoteDataSource {
  Future<ContactResponseModel> getContacts(String token);
}

class ContactRemoteDataSourceImpl implements ContactRemoteDataSource {
  final http.Client client;
  ContactRemoteDataSourceImpl({required this.client});

  @override
  Future<ContactResponseModel> getContacts(String token) async {
    final response = await client.get(
      Uri.parse('$baseUrl/odata/Contact'),
      headers: {
        'Content-Type': 'application/json',
        'accept': '*/*',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return contactResponseModelFromJson(response.body);
    } else {
      throw ServerException();
    }
  }
}
