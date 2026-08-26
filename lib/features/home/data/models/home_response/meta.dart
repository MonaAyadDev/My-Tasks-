class Meta {
  int? currentPage;
  int? lastPage;
  int? perPage;
  int? numberOfPages;
  int? total;

  Meta({
    this.currentPage,
    this.lastPage,
    this.perPage,
    this.numberOfPages,
    this.total,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    currentPage: json['current_page'] as int?,
    lastPage: json['last_page'] as int?,
    perPage: json['per_page'] as int?,
    numberOfPages: json['number_of_pages'] as int?,
    total: json['total'] as int?,
  );

  Map<String, dynamic> toJson() => {
    'current_page': currentPage,
    'last_page': lastPage,
    'per_page': perPage,
    'number_of_pages': numberOfPages,
    'total': total,
  };
}
