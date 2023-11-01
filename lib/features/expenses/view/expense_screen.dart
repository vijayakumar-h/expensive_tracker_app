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

  void openAddExpensesOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpenseScreen(onAddExpense: addExpenses),
    );
  }

  void addExpenses(Expense expense) {
    setState(() {
      expenseList.add(expense);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: const Text("Flutter ExpenseTracker"),
        actions: [
          IconButton(
            onPressed: openAddExpensesOverlay,
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: Column(
        children: [
          const Text("The charts"),
          ExpenseList(expenses: expenseList),
        ],
      ),
    );
  }
}
