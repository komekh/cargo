import 'dart:convert';

import '../../../domain/domain.dart';
import 'order_model.dart';
import 'pagination_data_model.dart';

OrderResponseModel orderResponseModelFromJson(String str) => OrderResponseModel.fromJson(json.decode(str));

// String orderResponseModelToJson(OrderResponseModel data) => json.encode(data.toJson());

class OrderResponseModel extends OrderResponse {
  OrderResponseModel({
    required PaginationMetaData meta,
    required List<OrderEntity> data,
  }) : super(orders: data, paginationMetaData: meta);

  factory OrderResponseModel.fromJson(Map<String, dynamic> json) => OrderResponseModel(
        meta: PaginationMetaDataModel(
          page: json['PageNumber'],
          pageSize: json['PageSize'],
          total: json['TotalRecords'],
        ),
        data: List<OrderModel>.from(json['Data'].map((x) => OrderModel.fromJson(x))),
      );

  /* Map<String, dynamic> toJson() => {
        'meta': (paginationMetaData as PaginationMetaDataModel).toJson(),
        'Data': List<dynamic>.from((orders as List<OrderModel>).map((x) => x.toJson())),
      }; */
}
