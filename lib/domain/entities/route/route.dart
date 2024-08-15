import 'package:equatable/equatable.dart';

class RouteEntity extends Equatable {
  final String name;
  final double lat;
  final double long;
  final bool isCurrent;

  const RouteEntity({
    required this.name,
    required this.lat,
    required this.long,
    required this.isCurrent,
  });

  @override
  List<Object?> get props => [name, lat, long, isCurrent];
}
