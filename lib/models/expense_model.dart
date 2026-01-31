import 'package:expensive_tracker_app/utils/common_exports.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();
const uuid = Uuid();

enum TransactionType { income, expense }

class CategoryModel {
  final String id;
  final String name;
  final int iconCode; // Store IconData.codePoint
  final TransactionType type;

  CategoryModel({
    required this.name,
    required this.iconCode,
    required this.type,
    String? id,
  }) : id = id ?? uuid.v4();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'iconCode': iconCode,
      'type': type.name,
    };
  }

  factory CategoryModel.fromMap(Map<dynamic, dynamic> map) {
    return CategoryModel(
      id: map['id'],
      name: map['name'],
      iconCode: map['iconCode'],
      type: TransactionType.values.firstWhere(
        (e) => e.name == map['type'],
        orElse: () => TransactionType.expense,
      ),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CategoryModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

class Expense {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final CategoryModel category;
  final TransactionType type;

  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
    required this.type,
    String? id,
  }) : id = id ?? uuid.v4();

  String get formattedDate => formatter.format(date);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'date': date.toIso8601String(),
      'category': category.toMap(),
      'type': type.name,
    };
  }

  factory Expense.fromMap(Map<dynamic, dynamic> map) {
    return Expense(
      id: map['id'],
      title: map['title'],
      amount: map['amount'],
      date: DateTime.parse(map['date']),
      category: CategoryModel.fromMap(map['category']),
      type: TransactionType.values.firstWhere(
        (e) => e.name == map['type'],
        orElse: () => TransactionType.expense,
      ),
    );
  }
}
