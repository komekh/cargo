import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/application.dart';
import '../../configs/configs.dart';
import '../../core/core.dart';
import 'dashed_line.dart';
import 'retry_widget.dart';

class LocationCard extends StatelessWidget {
  final String cargoId;
  const LocationCard({super.key, required this.cargoId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderDetailBloc, OrderDetailState>(
      builder: (context, state) {
        if (state is RoutesLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is RoutesLoaded) {
          final routes = state.routes;

          return SizedBox(
            width: double.infinity,
            child: Card(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final route = routes[index];
                    return Row(
                      children: [
                        route.isCurrent
                            ? const Icon(
                                Icons.radio_button_checked,
                                color: AppColors.primary,
                              )
                            : Container(
                                margin: Space.hf(0.35),
                                height: AppDimensions.normalize(4.5),
                                width: AppDimensions.normalize(4.5),
                                decoration: const BoxDecoration(
                                  color: AppColors.grey,
                                  shape: BoxShape.circle,
                                ),
                              ),
                        Space.x!,
                        Text(
                          routes[index].name,
                          style: AppText.b1b,
                        ),
                        const Spacer(),
                        Text(
                          routes[index].dateAt,
                          style: AppText.b1!.copyWith(color: AppColors.grey),
                        ),
                      ],
                    );
                  },
                  itemCount: routes.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: Space.vf(0.5),
                      child: DashedLine(
                        height: 1,
                        width: AppDimensions.normalize(8),
                        color: AppColors.lightGrey,
                        strokeWidth: 1,
                        dashWidth: 5,
                        dashSpace: AppDimensions.normalize(2),
                      ),
                    );
                  },
                ),
              ),
            ),
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
