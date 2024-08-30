import 'dart:async';

import 'package:another_stepper/another_stepper.dart';
import 'package:cargo/core/constants/colors.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/errors/failures.dart';
import '../../domain/entities/route/route.dart';
import '../../domain/usecases/order/get_routes_usecase.dart';
import '../../presentation/widgets/circle_painter.dart';

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
        (response) {
          // Find the index of the current route
          int currentIndex = response.routes.indexWhere((r) => r.isCurrent);

          emit(
            RoutesLoaded(
              routes: response.routes,
              activeIndex: currentIndex,
              steppers: response.routes.mapIndexed((index, route) {
                // Determine if the icon should be splashed
                final bool isSplashedIcon = index == 0 || index == response.routes.length - 1;

                // Determine the color based on the conditions
                Color textColor;
                Color iconColor;

                if (route.isCurrent) {
                  textColor = AppColors.greenDark;
                  iconColor = AppColors.greenDark;
                } else if (index < currentIndex) {
                  textColor = const Color(0xFFD8D8DA);
                  iconColor = AppColors.greenDark;
                } else {
                  textColor = AppColors.darkGrey;
                  iconColor = AppColors.darkGrey;
                }

                return StepperData(
                  title: StepperText(
                    route.name,
                    textStyle: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  subtitle: StepperText(
                    route.dateAt,
                    textStyle: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  iconWidget: isSplashedIcon
                      ? CircleWithGapWidget(
                          radius: 7,
                          fillColor: iconColor,
                          borderColor: iconColor,
                          borderWidth: 2,
                          gap: 3.0,
                        )
                      : CirclePainterWidget(
                          radius: 9,
                          color: iconColor,
                        ),
                );
              }).toList(),
            ),
            /* RoutesLoaded(
              routes: response.routes,
              steppers: response.routes.mapIndexed((index, route) {
                return StepperData(
                  title: StepperText(
                    route.name,
                    textStyle: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  subtitle: StepperText(route.dateAt),
                  iconWidget: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.all(
                        Radius.circular(18),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ), */
          );
        },
      );
    } catch (e) {
      emit(RoutesError(failure: ExceptionFailure()));
    }
  }
}
