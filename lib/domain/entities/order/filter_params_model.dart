class FilterProductParams {
  final int offset;
  final int limit;

  const FilterProductParams({
    this.offset = 1,
    this.limit = 10,
  });

  FilterProductParams copyWith({
    int? offset,
    int? limit,
  }) {
    return FilterProductParams(
      offset: offset ?? this.offset,
      limit: limit ?? this.limit,
    );
  }
}
