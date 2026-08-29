class RequestModel {
  int? taskId;
  String? title;
  String? description;
  String? status;
  String? deliveryDate;
  String? priority;
  String? createdAt;

  RequestModel({
    this.taskId,
    this.title,
    this.description,
    this.status,
    this.deliveryDate,
    this.priority,
    this.createdAt,
  });

  factory RequestModel.fromJson(Map<String, dynamic> json) => RequestModel(
    taskId: json['id'] as int? ?? json['taskId'] as int?,
    title: json['title'] as String?,
    description: json['description'] as String?,
    status: json['status'] as String?,
    deliveryDate:
        json['delivery_date'] as String? ?? json['deliveryDate'] as String?,
    priority: json['priority'] as String?,
    createdAt: json['created_at'] as String? ?? json['createdAt'] as String?,
  );

  Map<String, dynamic> toJson() => {
    if (taskId != null) 'taskId': taskId,
    'title': title,
    'description': description,
    'status': status,
    'delivery_date': deliveryDate,
    'priority': priority,
  };
}
