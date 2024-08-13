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
    App.init(context);

    return Scaffold(
      backgroundColor: AppColors.surface,
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
            context.read<OrderBloc>().add(const GetMoreOrders());
          }
          return false;
        },
        child: CustomScrollView(
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
            BlocBuilder<OrderBloc, OrderState>(
              builder: (context, state) {
                if (state is OrderLoading && state.orders.isEmpty) {
                  return const SliverToBoxAdapter(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (state is OrderError && state.orders.isEmpty) {
                  return SliverToBoxAdapter(
                    child: Center(
                      child: RetryWidget(onRetry: () {
                        context.read<OrderBloc>().add(GetOrders(state.params));
                      }),
                    ),
                  );
                } else if (state is OrderLoaded) {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        final order = state.orders[index];

                        if (index == state.orders.length - 1) {
                          // Trigger loading more orders when reaching the bottom
                          context.read<OrderBloc>().add(const GetMoreOrders());
                        }

                        return OrderCard(order: order);
                      },
                      childCount: state.orders.length,
                    ),
                  );
                } else {
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
      ),
    );
  }
}
