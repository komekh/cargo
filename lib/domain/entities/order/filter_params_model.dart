import 'package:cargo/core/core.dart';

class FilterProductParams {
  final int offset;
  final int limit;
  final GoodsState? state;

  const FilterProductParams({
    this.offset = 1,
    this.limit = 10,
    this.state,
  });

  FilterProductParams copyWith({
    int? offset,
    int? limit,
    GoodsState? state,
  }) {
    return FilterProductParams(
      offset: offset ?? this.offset,
      limit: limit ?? this.limit,
      state: state ?? this.state,
    );
  }
}
