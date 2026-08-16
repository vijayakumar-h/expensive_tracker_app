class Student {
  final String id;
  final String name;
  final bool isPresent;

  Student({
    required this.id,
    required this.name,
    this.isPresent = false,
  });

  Student copyWith({
    final String? id,
    final String? name,
    final bool? isPresent,
  }) {
    return Student(
      id: id ?? this.id,
      name: name ?? this.name,
      isPresent: isPresent ?? this.isPresent,
    );
  }

  factory Student.fromJson(Map<String, dynamic> json) => Student(
        id: json['id'],
        name: json['name'],
        isPresent: json['isPresent'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'isPresent': isPresent,
      };
}
