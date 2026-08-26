class Datum {
  int? taskId;
  String? title;
  String? description;
  String? status;
  String? deliveryDate;
  String? priority;
  String? createdAt;

  Datum({
    this.taskId,
    this.title,
    this.description,
    this.status,
    this.deliveryDate,
    this.priority,
    this.createdAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    taskId: json['taskId'] as int?,
    title: json['title'] as String?,
    description: json['description'] as String?,
    status: json['status'] as String?,
    deliveryDate: json['deliveryDate'] as String?,
    priority: json['priority'] as String?,
    createdAt: json['createdAt'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'taskId': taskId,
    'title': title,
    'description': description,
    'status': status,
    'deliveryDate': deliveryDate,
    'priority': priority,
    'createdAt': createdAt,
  };
}
