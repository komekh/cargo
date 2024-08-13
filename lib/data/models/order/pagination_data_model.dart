import 'package:cargo/domain/entities/order/pagination_meta_data.dart';

class PaginationMetaDataModel extends PaginationMetaData {
  PaginationMetaDataModel({
    required int page,
    required super.pageSize,
    required super.total,
  }) : super(limit: page);

  factory PaginationMetaDataModel.fromJson(Map<String, dynamic> json) => PaginationMetaDataModel(
        page: json['PageNumber'],
        pageSize: json['PageSize'],
        total: json['TotalRecords'],
      );

  Map<String, dynamic> toJson() => {
        'PageNumber': limit,
        'PageSize': pageSize,
        'TotalRecords': total,
      };
}
