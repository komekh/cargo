import 'pagination_meta_data.dart';
import 'order.dart';

class OrderResponse {
  final List<OrderEntity> orders;
  final PaginationMetaData paginationMetaData;

  OrderResponse({required this.orders, required this.paginationMetaData});
}
