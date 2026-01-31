import 'package:expensive_tracker_app/utils/common_exports.dart';
import 'package:expensive_tracker_app/features/chart/chart_screen.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  List<Expense> expenseList = [];

  @override
  void initState() {
    super.initState();
    expenseList = appController.expenses;
  }

  final DraggableScrollableController draggableController =
      DraggableScrollableController();

  void addExpenses(Expense expense) async {
    await appController.saveExpense(expense.id, expense.toMap());
    setState(() {
      expenseList.insert(0, expense);
    });
  }

  void removeExpenses(Expense expense) {
    appController.removeExpense(expense.id);
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
            appController.saveExpense(expense.id, expense.toMap());
            setState(() {
              expenseList.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  void _openAddExpenseOverlay({Expense? expense}) {
    appController.draggableBottomSheet(
      context: context,
      maxChildSize: 0.9,
      minChildSize: 0.65,
      initialChildSize: 0.65,
      draggableController: draggableController,
      builder: (context, scrollController) => NewExpenseScreen(
        onAddExpense: addExpenses,
        scrollController: scrollController,
        draggableController: draggableController,
        existingExpense: expense,
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
        onEditExpense: (expense) => _openAddExpenseOverlay(expense: expense),
      );
    }
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          automaticallyImplyLeading: false,
          title: const Text("Tracker"),
          foregroundColor: Theme.of(context).primaryColor,
          bottom: TabBar(
            splashFactory: NoSplash.splashFactory,
            dividerColor: Colors.transparent,
            indicatorColor: Theme.of(context).primaryColor,
            labelColor: Theme.of(context).primaryColor,
            unselectedLabelColor: Theme.of(context).textTheme.bodyMedium?.color,
            tabs: const [
              Tab(text: "Transactions", icon: Icon(Icons.list)),
              Tab(text: "Reports", icon: Icon(Icons.bar_chart)),
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: InkWell(
                onTap: () => _openAddExpenseOverlay(),
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  height: 48,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color:
                        Theme.of(context).primaryColor.withValues(alpha: 0.1),
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
        body: TabBarView(
          children: [
            // Tab 1: Transaction List
            Column(
              children: [
                Expanded(child: mainContent),
              ],
            ),
            // Tab 2: Reports / Charts
            ChartScreen(expenses: expenseList),
          ],
        ),
      ),
    );
  }
}
