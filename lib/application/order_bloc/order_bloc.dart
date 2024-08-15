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
      : super(
          OrderInitial(
            orders: const [],
            params: const FilterProductParams(),
            metaData: PaginationMetaData(
              pageSize: 10,
              limit: 0,
              total: 0,
            ),
          ),
        ) {
    on<GetOrders>(_onGetOrders);
    on<GetMoreOrders>(_onLoadMoreOrders);
  }

  FutureOr<void> _onGetOrders(GetOrders event, Emitter<OrderState> emit) async {
    try {
      emit(OrderLoading(
        orders: const [],
        metaData: state.metaData,
        params: event.params,
      ));
      final result = await _getOrdersUseCase(event.params);
      result.fold(
        (failure) => emit(OrderError(
          orders: state.orders,
          metaData: state.metaData,
          failure: failure,
          params: event.params,
        )),
        (response) => emit(OrderLoaded(
          metaData: response.paginationMetaData,
          orders: response.orders,
          params: event.params,
        )),
      );
    } catch (e) {
      emit(OrderError(
        orders: state.orders,
        metaData: state.metaData,
        failure: ExceptionFailure(),
        params: event.params,
      ));
    }
  }

  Future<void> _onLoadMoreOrders(GetMoreOrders event, Emitter<OrderState> emit) async {
    var state = this.state;
    var limit = state.metaData.limit;
    var total = state.metaData.total;
    var loadedProductsLength = state.orders.length;
    // check state and loaded products amount[loadedProductsLength] compare with
    // number of results total[total] results available in server
    if (state is OrderLoaded && (loadedProductsLength < total)) {
      try {
        emit(OrderLoading(
          orders: state.orders,
          metaData: state.metaData,
          params: state.params,
        ));
        final result = await _getOrdersUseCase(FilterProductParams(limit: limit + 10));
        result.fold(
          (failure) => emit(OrderError(
            orders: state.orders,
            metaData: state.metaData,
            failure: failure,
            params: state.params,
          )),
          (response) {
            List<OrderEntity> products = state.orders;
            products.addAll(response.orders);
            emit(OrderLoaded(
              metaData: state.metaData,
              orders: products,
              params: state.params,
            ));
          },
        );
      } catch (e) {
        emit(OrderError(
          orders: state.orders,
          metaData: state.metaData,
          failure: ExceptionFailure(),
          params: state.params,
        ));
      }
    }
  }
}
