import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'category_model.dart';

final formatter = DateFormat.yMd();

enum TransactionType { expense, income }

class Expense extends Equatable {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final CategoryModel category;
  final TransactionType type;

  Expense({
    String? id,
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
    this.type = TransactionType.expense,
  }) : id = id ?? const Uuid().v4();

  String get formattedDate {
    return formatter.format(date);
  }

  factory Expense.fromMap(Map<dynamic, dynamic> map) {
    return Expense(
      id: map['id'] as String?,
      title: map['title'] as String? ?? '',
      amount: (map['amount'] as num?)?.toDouble() ?? 0.0,
      date: map['date'] != null
          ? DateTime.parse(map['date'] as String)
          : DateTime.now(),
      category: map['category'] != null
          ? CategoryModel.fromMap(
              Map<dynamic, dynamic>.from(map['category'] as Map))
          : CategoryModel(
              name: 'General',
              iconCode: 0,
              type: TransactionType.expense,
            ),
      type: map['type'] == 'income'
          ? TransactionType.income
          : TransactionType.expense,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'date': date.toIso8601String(),
      'category': category.toMap(),
      'type': type == TransactionType.income ? 'income' : 'expense',
    };
  }

  Expense copyWith({
    String? id,
    String? title,
    double? amount,
    DateTime? date,
    CategoryModel? category,
    TransactionType? type,
  }) {
    return Expense(
      id: id ?? this.id,
      title: title ?? this.title,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      category: category ?? this.category,
      type: type ?? this.type,
    );
  }

  @override
  List<Object?> get props => [id, title, amount, date, category, type];
}

class CategoryBucket {
  final CategoryModel category;
  final List<Expense> expenses;

  const CategoryBucket({
    required this.category,
    required this.expenses,
  });

  CategoryBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.category.id == category.id)
            .toList();

  double get totalExpenses {
    double sum = 0;
    for (final expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }
}
