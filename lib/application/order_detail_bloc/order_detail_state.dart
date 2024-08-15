part of 'order_detail_bloc.dart';

sealed class OrderDetailState extends Equatable {
  const OrderDetailState();

  @override
  List<Object> get props => [];
}

class OrderDetailInitial extends OrderDetailState {}

class RoutesLoading extends OrderDetailState {}

class RoutesLoaded extends OrderDetailState {
  final List<RouteEntity> routes;
  const RoutesLoaded({required this.routes});
  @override
  List<Object> get props => [routes];
}

class RoutesError extends OrderDetailState {
  final Failure failure;
  const RoutesError({
    required this.failure,
  });

  @override
  List<Object> get props => [];
}
