import 'package:expensive_tracker_app/utils/common_exports.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  List<Expense> expenseList = [
    Expense(
      title: "Flutter Course",
      amount: 20.01,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: "Cinema",
      amount: 19.80,
      date: DateTime.now(),
      category: Category.travel,
    ),
    Expense(
      title: "Chicken",
      amount: 30.01,
      date: DateTime.now(),
      category: Category.food,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          const Text("The charts"),
          ExpenseList(expenses: expenseList),
        ],
      ),
    );
  }
}
