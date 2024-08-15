import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/errors/failures.dart';
import '../../domain/entities/route/route.dart';
import '../../domain/usecases/order/get_routes_usecase.dart';

part 'order_detail_event.dart';
part 'order_detail_state.dart';

class OrderDetailBloc extends Bloc<OrderDetailEvent, OrderDetailState> {
  final GetRoutesUseCase _getRoutesUseCase;

  OrderDetailBloc(this._getRoutesUseCase) : super(OrderDetailInitial()) {
    on<GetRoutes>(_onGetRoutes);
  }

  FutureOr<void> _onGetRoutes(GetRoutes event, Emitter<OrderDetailState> emit) async {
    try {
      emit(RoutesLoading());
      final result = await _getRoutesUseCase(event.cargoId);
      result.fold(
        (failure) => emit(RoutesError(failure: failure)),
        (response) => emit(RoutesLoaded(routes: response.routes)),
      );
    } catch (e) {
      emit(RoutesError(failure: ExceptionFailure()));
    }
  }
}
