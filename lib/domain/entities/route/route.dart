import 'package:equatable/equatable.dart';

class RouteEntity extends Equatable {
  final String name;
  final double lat;
  final double long;
  final bool isCurrent;
  final String dateAt;

  const RouteEntity({
    required this.name,
    required this.lat,
    required this.long,
    required this.isCurrent,
    required this.dateAt,
  });

  @override
  List<Object?> get props => [name, lat, long, isCurrent, dateAt];
}
