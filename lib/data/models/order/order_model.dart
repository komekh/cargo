import 'package:cargo/core/core.dart';

import '../../../domain/domain.dart';

class OrderModel extends OrderEntity {
  const OrderModel({
    required super.oid,
    required super.clientId,
    required super.cargoId,
    required super.state,
    required super.no,
    required super.name,
    required super.shopNo,
    required super.volume,
    required super.placesCount,
    required super.carrier,
    required super.from,
    required super.to,
    required super.departedAt,
    required super.arrivedAt,
    required super.depth,
    required super.width,
    required super.height,
  });
  // Factory method to create an instance of CargoEntity from JSON
  factory OrderModel.fromJson(Map<String, dynamic> json) {
    DateTime? departedAt = json['DepartedAt'] != null ? DateTime.parse(json['DepartedAt']) : null;
    DateTime? arrivedAt = json['ArrivedAt'] != null ? DateTime.parse(json['ArrivedAt']) : null;
    return OrderModel(
      oid: json['Oid'],
      clientId: json['ClientId'],
      cargoId: json['CargoId'],
      state: json['State'],
      no: json['No'],
      name: json['Name'],
      shopNo: json['ShopNo'],
      volume: json['Volume'].toDouble(),
      placesCount: json['PlacesCount'],
      carrier: json['Carrier'],
      from: json['From'],
      to: json['To'],
      departedAt: DateUtil.formatDateTimeToDDMMYYYY(departedAt),
      arrivedAt: DateUtil.formatDateTimeToDDMMYYYY(arrivedAt),
      depth: json['Depth'].toDouble(),
      width: json['Width'].toDouble(),
      height: json['Height'].toDouble(),
    );
  }

  // Method to convert CargoEntity to JSON
  Map<String, dynamic> toJson() {
    return {
      'Oid': oid,
      'ClientId': clientId,
      'CargoId': cargoId,
      'State': state,
      'No': no,
      'Name': name,
      'ShopNo': shopNo,
      'Volume': volume,
      'PlacesCount': placesCount,
      'Carrier': carrier,
      'From': from,
      'To': to,
      'DepartedAt': departedAt,
      'ArrivedAt': arrivedAt,
      'Depth': depth,
      'Width': width,
      'Height': height,
    };
  }
}
