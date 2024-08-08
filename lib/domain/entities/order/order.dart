import 'package:equatable/equatable.dart';

class OrderEntity extends Equatable {
  final String oid;
  final String clientId;
  final String cargoId;
  final String state;
  final String no;
  final String name;
  final String shopNo;
  final double volume;
  final int placesCount;
  final String carrier;
  final String from;
  final String to;
  final String departedAt;
  final String arrivedAt;
  final double depth;
  final double width;
  final double height;

  const OrderEntity({
    required this.oid,
    required this.clientId,
    required this.cargoId,
    required this.state,
    required this.no,
    required this.name,
    required this.shopNo,
    required this.volume,
    required this.placesCount,
    required this.carrier,
    required this.from,
    required this.to,
    required this.departedAt,
    required this.arrivedAt,
    required this.depth,
    required this.width,
    required this.height,
  });

  @override
  List<Object?> get props => [oid];
}
