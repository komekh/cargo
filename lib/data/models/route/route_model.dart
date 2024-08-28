import 'package:cargo/domain/domain.dart';

import '../../../core/utils/date_util.dart';

class RouteModel extends RouteEntity {
  const RouteModel({
    required super.name,
    required super.lat,
    required super.long,
    required super.isCurrent,
    required super.dateAt,
  });

  factory RouteModel.fromJson(Map<String, dynamic> json) {
    DateTime? dateAt = json['DateAt'] != null ? DateTime.parse(json['DateAt']) : null;
    return RouteModel(
      name: json['Name'],
      lat: json['Lat'] + .0,
      long: json['Long'] + .0,
      isCurrent: json['IsCurrent'],
      dateAt: DateUtil.formatDateTimeToDDMMYYYY(dateAt),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Name': name,
      'Lat': lat,
      'Long': long,
      'IsCurrent': isCurrent,
      'DateAt': dateAt,
    };
  }
}
