import 'package:another_stepper/another_stepper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/application.dart';
import '../../configs/configs.dart';
import '../../core/core.dart';
import 'retry_widget.dart';

class LocationCard extends StatelessWidget {
  final String cargoId;
  const LocationCard({super.key, required this.cargoId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderDetailBloc, OrderDetailState>(
      builder: (context, state) {
        if (state is RoutesLoading) {
          return const SizedBox.shrink();
          // const Center(
          //   child: CircularProgressIndicator(),
          // );
        } else if (state is RoutesLoaded) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'route'.tr(),
                style: AppText.h2b,
              ),

              /// gap
              Space.y!,
              SizedBox(
                width: double.infinity,
                child: Card(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: AnotherStepper(
                      stepperList: state.steppers,
                      stepperDirection: Axis.vertical,
                      iconWidth: 30,
                      iconHeight: 30,
                      activeBarColor: AppColors.greenDark,
                      inActiveBarColor: AppColors.darkGrey,
                      inverted: false,
                      verticalGap: 25,
                      activeIndex: state.activeIndex,
                      barThickness: 2.6,
                    ),
                  ),
                ),
              ),
            ],
          );
        } else if (state is RoutesError) {
          return Center(
            child: RetryWidget(onRetry: () {
              context.read<OrderDetailBloc>().add(GetRoutes(cargoId));
            }),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
