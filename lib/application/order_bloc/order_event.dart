part of 'order_bloc.dart';

sealed class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class GetOrders extends OrderEvent {
  final FilterProductParams params;
  const GetOrders(this.params);

  @override
  List<Object> get props => [];
}

class GetMoreOrders extends OrderEvent {
  const GetMoreOrders();
  @override
  List<Object> get props => [];
}
