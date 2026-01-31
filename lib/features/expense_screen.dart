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
  ];

  @override
  void initState() {
    super.initState();
    expenseList = appController.expenses;
  }

  final DraggableScrollableController draggableController =
      DraggableScrollableController();

  void addExpenses(Expense expense) async {
    await appController.storeFromHive(expense.id, expense.toMap());
    setState(() {
      expenseList.insert(0, expense);
    });
  }

  void removeExpenses(Expense expense) {
    appController.deleteFromHive(expense.id);
    final expenseIndex = expenseList.indexOf(expense);
    setState(() {
      expenseList.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("Expenses deleted"),
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            appController.storeFromHive(expense.id, expense.toMap());
            setState(() {
              expenseList.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Text("No expense found, Start adding some!"),
    );
    if (expenseList.isNotEmpty) {
      mainContent = ExpenseList(
        expenses: expenseList,
        onRemoveExpense: removeExpenses,
      );
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: const Text("Tracker"),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: InkWell(
              onTap: () => appController.draggableBottomSheet(
                context: context,
                maxChildSize: 0.9,
                minChildSize: 0.65,
                initialChildSize: 0.65,
                draggableController: draggableController,
                builder: (context, scrollController) => NewExpenseScreen(
                  onAddExpense: addExpenses,
                  scrollController: scrollController,
                  draggableController: draggableController,
                ),
              ),
              borderRadius: BorderRadius.circular(30),
              child: Container(
                height: 48,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color:
                        Theme.of(context).primaryColor.withValues(alpha: 0.2),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.add_rounded,
                      size: 28,
                      color: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Add',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          const Text("The charts"),
          Expanded(child: mainContent),
        ],
      ),
    );
  }
}
