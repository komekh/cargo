import 'package:cargo/core/core.dart';

class FilterProductParams {
  final int offset;
  final int limit;
  final OrderFilter? filter;

  const FilterProductParams({
    this.offset = 1,
    this.limit = 10,
    this.filter,
  });

  FilterProductParams copyWith({
    int? offset,
    int? limit,
    OrderFilter? filter,
  }) {
    return FilterProductParams(
      offset: offset ?? this.offset,
      limit: limit ?? this.limit,
      filter: filter ?? this.filter,
    );
  }
}
