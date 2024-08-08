part of 'order_bloc.dart';

abstract class OrderState extends Equatable {
  final List<OrderEntity> orders;
  final FilterProductParams params;
  const OrderState({required this.orders, required this.params});
}

class OrderInitial extends OrderState {
  const OrderInitial({
    required super.orders,
    required super.params,
  });
  @override
  List<Object> get props => [];
}

class OrderEmpty extends OrderState {
  const OrderEmpty({
    required super.orders,
    required super.params,
  });
  @override
  List<Object> get props => [];
}

class OrderLoading extends OrderState {
  const OrderLoading({
    required super.orders,
    required super.params,
  });
  @override
  List<Object> get props => [];
}

class OrderLoaded extends OrderState {
  const OrderLoaded({
    required super.orders,
    required super.params,
  });
  @override
  List<Object> get props => [orders];
}

class OrderError extends OrderState {
  final Failure failure;
  const OrderError({
    required super.orders,
    required super.params,
    required this.failure,
  });
  @override
  List<Object> get props => [];
}
