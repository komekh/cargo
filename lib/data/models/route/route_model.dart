import 'package:cargo/domain/domain.dart';

class RouteModel extends RouteEntity {
  const RouteModel({
    required super.name,
    required super.lat,
    required super.long,
    required super.isCurrent,
  });

  factory RouteModel.fromJson(Map<String, dynamic> json) {
    return RouteModel(
      name: json['Name'],
      lat: json['Lat'] + .0,
      long: json['Long'] + .0,
      isCurrent: json['IsCurrent'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Name': name,
      'Lat': lat,
      'Long': long,
      'IsCurrent': isCurrent,
    };
  }
}
