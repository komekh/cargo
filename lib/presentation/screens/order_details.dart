import 'package:cargo/application/application.dart';
import 'package:cargo/configs/configs.dart';
import 'package:cargo/domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/core.dart';
import '../widgets/map/clustering.dart';
import '../widgets/widgets.dart';

class OrderDetailsScreen extends StatefulWidget {
  final OrderEntity order;
  const OrderDetailsScreen({super.key, required this.order});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  @override
  void initState() {
    context.read<OrderDetailBloc>().add(GetRoutes(widget.order.cargoId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    App.init(context);
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: AppColors.primary,
        title: Text(
          'Sargyt №ABC456789',
          style: AppText.h2!.copyWith(color: Colors.white),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          /// map
          SliverToBoxAdapter(
            child: SizedBox(
              height: AppDimensions.normalize(120),
              child: const ClusteringPage(),
            ),
          ),

          /// info text
          SliverToBoxAdapter(
            child: Padding(
              padding: Space.all(1, 1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sargyt barada maglumat №ABC456789',
                    style: AppText.b1b,
                  ),

                  /// gap
                  Space.y!,

                  /// info card
                  const InfoCard(),
                ],
              ),
            ),
          ),

          /// current location info
          SliverToBoxAdapter(
            child: Padding(
              padding: Space.all(1, 1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Gatnaw yoly',
                    style: AppText.b1b,
                  ),

                  /// gap
                  Space.y!,

                  /// location card
                  LocationCard(cargoId: widget.order.cargoId)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
