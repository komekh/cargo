import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/core.dart';
import '../../domain/domain.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final GetOrderUseCase _getOrdersUseCase;
  OrderBloc(this._getOrdersUseCase)
      : super(const OrderInitial(
          orders: [],
          params: FilterProductParams(),
        )) {
    on<GetOrders>(_onGetOrders);
  }

  FutureOr<void> _onGetOrders(
    GetOrders event,
    Emitter<OrderState> emit,
  ) async {
    try {
      emit(OrderLoading(
        orders: const [],
        params: event.params,
      ));
      final result = await _getOrdersUseCase(event.params);
      result.fold(
        (failure) => emit(OrderError(
          orders: state.orders,
          failure: failure,
          params: event.params,
        )),
        (orders) => emit(OrderLoaded(
          orders: orders,
          params: event.params,
        )),
      );
    } catch (e) {
      emit(OrderError(
        orders: state.orders,
        failure: ExceptionFailure(),
        params: event.params,
      ));
    }
  }
}
