import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/order_detail_bloc/order_detail_bloc.dart';
import '../../configs/configs.dart';
import '../../core/core.dart';
import '../../domain/entities/order/order.dart';
import '../widgets/map/clustering.dart';
import '../widgets/widgets.dart';

class OrderDetailsScreen extends StatefulWidget {
  final OrderEntity order;

  const OrderDetailsScreen({super.key, required this.order});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  bool _isFullScreen = false; // Track fullscreen mode
  bool _showLocation = true;

  @override
  void initState() {
    context.read<OrderDetailBloc>().add(GetRoutes(widget.order.cargoId));
    _checkLocationStatus();
    super.initState();
  }

  void _checkLocationStatus() {
    setState(() {
      debugPrint('NAME: ${GoodsState.Reserved.name}');
      _showLocation = widget.order.state != GoodsState.Reserved.name;
    });
  }

  void _toggleFullScreen() {
    setState(() {
      _isFullScreen = !_isFullScreen;

      if (_isFullScreen) {
        // Enter fullscreen mode
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
      } else {
        // Exit fullscreen mode
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    App.init(context);
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: _isFullScreen
          ? null // Hide the app bar in fullscreen mode
          : AppBar(
              iconTheme: const IconThemeData(
                color: Colors.white,
              ),
              backgroundColor: AppColors.primary,
              title: Text(
                '${'order'.tr()} №${widget.order.no}',
                style: AppText.h2!.copyWith(color: Colors.white),
              ),
            ),
      body: CustomScrollView(
        slivers: [
          /// map
          if (_showLocation)
            SliverToBoxAdapter(
              child: SizedBox(
                height: _isFullScreen
                    ? MediaQuery.of(context).size.height // Full screen height
                    : AppDimensions.normalize(130),
                child: ClusteringPage(
                  onFullScreenToggle: _toggleFullScreen,
                  isFullScreen: _isFullScreen,
                ),
              ),
            ),

          if (!_isFullScreen) ...[
            /// info text
            SliverToBoxAdapter(
              child: Padding(
                padding: Space.all(1, 1),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${'order_info'.tr()} №${widget.order.no}',
                      style: AppText.b1b,
                    ),

                    /// gap
                    Space.y!,

                    /// info card
                    InfoCard(order: widget.order),
                  ],
                ),
              ),
            ),

            /// current location info
            if (_showLocation)
              SliverToBoxAdapter(
                child: Padding(
                  padding: Space.all(1, 1),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'route'.tr(),
                        style: AppText.b1b,
                      ),

                      /// gap
                      Space.y!,

                      /// location card
                      LocationCard(cargoId: widget.order.cargoId),
                    ],
                  ),
                ),
              ),
          ],
        ],
      ),
    );
  }
}
