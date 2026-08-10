import 'package:expensive_tracker_app/common_exports.dart';

class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({super.key});

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      context: context,
      isScrollControlled: true,
      builder: (ctx) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        expand: false,
        builder: (context, scrollController) {
          return NewExpenseScreen(
            onAddExpense: _addExpense,
            scrollController: scrollController,
            draggableController: DraggableScrollableController(),
          );
        },
      ),
    );
  }

  void _addExpense(Expense expense) {
    context.read<ExpenseBloc>().add(AddExpenseEvent(expense));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.of(context).size.width;

    return BlocBuilder<ExpenseBloc, ExpenseState>(
      builder: (context, state) {
        final expenses = state.expenses;
        final totalIncome = expenses
            .where((e) => e.type == TransactionType.income)
            .fold(0.0, (sum, e) => sum + e.amount);
        final totalExpense = expenses
            .where((e) => e.type == TransactionType.expense)
            .fold(0.0, (sum, e) => sum + e.amount);
        final totalBalance = totalIncome - totalExpense;

        Widget mainContent = Center(
          child: Text(
            context.l10n('no_expense'),
            style: const TextStyle(fontSize: 16),
          ),
        );

        if (expenses.isNotEmpty) {
          mainContent = ExpenseList(expenses: expenses);
        }

        return Scaffold(
          appBar: AppBar(
            centerTitle: false,
            title: Text(
              context.l10n('app_title'),
              style: TextStyle(
                fontSize: 24,
                inherit: true,
                fontWeight: FontWeight.bold,
                color: AppTheme().light.primaryColor,
              ),
            ),
            actions: [
              AppIconButton(
                tooltip: "Add",
                icon: Icons.add,
                buttonCallback: _openAddExpenseOverlay,
              ),
              SizedBox(width: 8),
              AppIconButton(
                  tooltip: "Reports",
                  icon: Icons.pie_chart_rounded,
                  buttonCallback: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChartScreen(expenses: expenses),
                      ),
                    );
                  }),
              SizedBox(width: 8),
            ],
          ),
          drawer: const AppDrawer(),
          body: Column(
            children: [
              Container(
                width: double.infinity,
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      theme.primaryColor,
                      theme.primaryColor.withValues(alpha: 0.8),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: theme.primaryColor.withValues(alpha: 0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.l10n('total_balance'),
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '\$${totalBalance.toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const CircleAvatar(
                              radius: 14,
                              backgroundColor: Colors.white24,
                              child: Icon(Icons.arrow_downward,
                                  color: Colors.greenAccent, size: 16),
                            ),
                            const SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  context.l10n('income'),
                                  style: const TextStyle(
                                      color: Colors.white70, fontSize: 12),
                                ),
                                Text(
                                  '\$${totalIncome.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const CircleAvatar(
                              radius: 14,
                              backgroundColor: Colors.white24,
                              child: Icon(Icons.arrow_upward,
                                  color: Colors.redAccent, size: 16),
                            ),
                            const SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  context.l10n('expenses'),
                                  style: const TextStyle(
                                      color: Colors.white70, fontSize: 12),
                                ),
                                Text(
                                  '\$${totalExpense.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      context.l10n('transactions'),
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${expenses.length} items',
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: width < 600
                    ? mainContent
                    : Row(
                        children: [
                          Expanded(child: mainContent),
                        ],
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}
