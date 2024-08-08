class FilterProductParams {
  final int? limit;
  final int? pageSize;

  const FilterProductParams({
    this.limit = 0,
    this.pageSize = 10,
  });

  FilterProductParams copyWith({
    int? skip,
    int? limit,
    int? pageSize,
  }) =>
      FilterProductParams(
        limit: skip ?? this.limit,
        pageSize: pageSize ?? this.pageSize,
      );
}
