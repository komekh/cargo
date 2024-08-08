import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/order_bloc/order_bloc.dart';
import '../../configs/configs.dart';
import '../../core/core.dart';
import '../widgets/widgets.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Initialize the context (if needed)
    App.init(context);

    // Provide the OrderBloc
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: OrderHeader(),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: Space.all(1, 1),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sargytlarym',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'öz ýüküňizi yzarlaň',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Use BlocBuilder to respond to state changes
          BlocBuilder<OrderBloc, OrderState>(
            builder: (context, state) {
              if (state is OrderLoading) {
                // Display a loading indicator while fetching orders
                return const SliverToBoxAdapter(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (state is OrderError) {
                // Display an error message if there was a failure
                return SliverToBoxAdapter(
                  child: Center(
                    child: Text(
                      'Failed to load orders: ${state.failure}',
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                );
              } else if (state is OrderLoaded) {
                // Display the list of orders
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      final order = state.orders[index];
                      return OrderCard(order: order);
                    },
                    childCount: state.orders.length,
                  ),
                );
              } else {
                // Default case (initial state)
                return const SliverToBoxAdapter(
                  child: Center(
                    child: Text('No orders available'),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
