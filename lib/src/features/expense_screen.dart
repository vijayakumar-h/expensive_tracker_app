import 'package:expensive_tracker_app/src/utils/common_exports.dart';
import 'package:expensive_tracker_app/src/features/chart/chart_screen.dart';

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
        content: Text(context.l10n('expense_deleted')),
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: context.l10n('undo'),
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
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, settingsState) {
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            drawer: const AppDrawer(),
            appBar: AppBar(
              centerTitle: false,
              automaticallyImplyLeading: true,
              title: Text(context.l10n('app_title')),
              foregroundColor: Theme.of(context).primaryColor,
              bottom: TabBar(
                splashFactory: NoSplash.splashFactory,
                dividerColor: Colors.transparent,
                indicatorColor: Theme.of(context).primaryColor,
                labelColor: Theme.of(context).primaryColor,
                unselectedLabelColor: Theme.of(context).textTheme.bodyMedium?.color,
                tabs: [
                  Tab(text: context.l10n('transactions'), icon: const Icon(Icons.list)),
                  Tab(text: context.l10n('reports'), icon: const Icon(Icons.bar_chart)),
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
                            context.l10n('add'),
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
                
                Widget mainContent = Center(
                  child: Text(context.l10n('no_expense')),
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
      },
    );
  }
}
