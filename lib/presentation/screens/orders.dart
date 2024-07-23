import 'package:flutter/material.dart';

import '../../configs/configs.dart';
import '../../core/core.dart';
import '../widgets/order_header.dart';

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
                return _buildOrderCard();
              },
              childCount: 4, // items.length,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderCard() {
    return Card(
      color: Colors.white,
      margin: Space.all(.8, 0.5),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '№ABC456789',
                  style: AppText.b1b,
                ),
                Text(
                  'Genişleýin >',
                  style: AppText.b1b?.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Row(
              children: [
                Icon(Icons.circle, color: Colors.green, size: 12),
                SizedBox(width: 4),
                Text('Ýolda'),
                Spacer(),
                Text('Ugradylan senesi: 16.07.2024'),
              ],
            ),
            const SizedBox(height: 16),
            const Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Nireden:'),
                    Text('Urumçy', style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    Text('Nirede:'),
                    Text('Aşgabat', style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('Ýer sany:'),
                    Text('10', style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    Text('Göwrümi:'),
                    Text('1472,31', style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Maşyn №:'),
                    Text('AA1234AA', style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    Text('Dukan №:'),
                    Text('A1043', style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
