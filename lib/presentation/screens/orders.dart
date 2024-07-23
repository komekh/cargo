import 'package:cargo/presentation/presentation.dart';
import 'package:flutter/material.dart';

import '../../configs/configs.dart';
import '../../core/core.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    App.init(context);
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
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return const OrderCard();
              },
              childCount: 4, // items.length,
            ),
          ),
        ],
      ),
    );
  }
}
