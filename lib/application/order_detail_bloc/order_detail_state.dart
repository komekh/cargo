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
  final List<StepperData> steppers;
  final int activeIndex;
  const RoutesLoaded({
    required this.routes,
    required this.steppers,
    required this.activeIndex,
  });
  @override
  List<Object> get props => [routes, steppers, activeIndex];
}

class RoutesError extends OrderDetailState {
  final Failure failure;
  const RoutesError({
    required this.failure,
  });

  @override
  List<Object> get props => [];
}
