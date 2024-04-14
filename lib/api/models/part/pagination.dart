class Links {
  Links({
    required this.first,
    required this.last,
    this.prev,
    this.next,
  });

  String first;
  String last;
  String? prev;
  String? next;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        first: json["first"],
        last: json["last"],
        prev: json["prev"] == null ? null : json["prev"],
        next: json["next"] == null ? null : json["next"],
      );

  Map<String, dynamic> toJson() => {
        "first": first,
        "last": last,
        "prev": prev == null ? null : prev,
        "next": next == null ? null : next,
      };
}

class Meta {
  Meta({
    required this.currentPage,
    this.from,
    required this.lastPage,
    required this.path,
    required this.perPage,
    this.to,
    required this.total,
  });

  int currentPage;
  int? from;
  int lastPage;
  String path;
  String perPage;
  int? to;
  int total;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        currentPage: json["current_page"],
        from: json["from"] == null ? null : json["from"],
        lastPage: json["last_page"],
        path: json["path"],
        perPage: json["per_page"].toString(),
        to: json["to"] == null ? null : json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "from": from == null ? null : from,
        "last_page": lastPage,
        "path": path,
        "per_page": perPage,
        "to": to == null ? null : to,
        "total": total,
      };
}
