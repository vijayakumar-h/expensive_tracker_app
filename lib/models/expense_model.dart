import 'package:expensive_tracker_app/utils/common_exports.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();
const uuid = Uuid();

enum Category { food, travel, leisure, work }

const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff_sharp,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
};

class Expense {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  String get formattedDate => formatter.format(date);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'date': date.toIso8601String(),
      'category': category.name,
    };
  }

  factory Expense.fromMap(Map<dynamic, dynamic> map) {
    return Expense(
      title: map['title'] as String,
      amount: map['amount'] as double,
      date: DateTime.parse(map['date'] as String),
      category: Category.values.firstWhere(
        (e) => e.name == map['category'],
        orElse: () => Category.food,
      ),
    );
  }
}
