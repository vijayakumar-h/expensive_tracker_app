class TaskModel {
  final String id;
  final String title;
  final bool isComplete;

  TaskModel({
    required this.id,
    required this.title,
    this.isComplete = false,
  });

  TaskModel copyWith({
    final String? id,
    final String? title,
    final bool? isComplete,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      isComplete: isComplete ?? this.isComplete,
    );
  }

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      title: json['title'],
      isComplete: json['isComplete'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'isComplete': isComplete,
      };
}
