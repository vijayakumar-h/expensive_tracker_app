import 'package:expensive_tracker_app/utils/common_exports.dart';
import 'package:expensive_tracker_app/features/chart/chart_screen.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final DraggableScrollableController draggableController =
      DraggableScrollableController();

  void removeExpenses(Expense expense) {
    context.read<ExpenseBloc>().add(DeleteExpenseEvent(expense.id));
    
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("Expenses deleted"),
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            context.read<ExpenseBloc>().add(AddExpenseEvent(expense));
          },
        ),
      ),
    );
  }

  void _openAddExpenseOverlay({Expense? expense}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(kAppBorderRadius),
        borderSide: const BorderSide(
          width: 0.0,
          style: BorderStyle.none,
          color: Colors.transparent,
        ),
      ),
      sheetAnimationStyle: AnimationStyle(
        curve: Curves.easeIn,
        reverseCurve: Curves.easeOut,
        duration: const Duration(milliseconds: 300),
        reverseDuration: const Duration(milliseconds: 300),
      ),
      builder: (BuildContext context) => DraggableScrollableSheet(
        expand: false,
        controller: draggableController,
        minChildSize: 0.65,
        maxChildSize: 0.9,
        initialChildSize: 0.65,
        builder: (context, scrollController) => NewExpenseScreen(
          onAddExpense: (newExpense) {
            context.read<ExpenseBloc>().add(AddExpenseEvent(newExpense));
          },
          scrollController: scrollController,
          draggableController: draggableController,
          existingExpense: expense,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
            body: BlocBuilder<ExpenseBloc, ExpenseState>(
              builder: (context, state) {
                final expenseList = state.expenses;
                
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

                return TabBarView(
                  children: [
                    Column(
                      children: [
                        Expanded(child: mainContent),
                      ],
                    ),
                    ChartScreen(expenses: expenseList),
                  ],
                );
              },
            ),
          ),
        );
  }
}
