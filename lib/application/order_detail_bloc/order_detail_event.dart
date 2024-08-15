part of 'order_detail_bloc.dart';

sealed class OrderDetailEvent extends Equatable {
  const OrderDetailEvent();

  @override
  List<Object> get props => [];
}

class GetRoutes extends OrderDetailEvent {
  final String cargoId;
  const GetRoutes(this.cargoId);

  @override
  List<Object> get props => [];
}
