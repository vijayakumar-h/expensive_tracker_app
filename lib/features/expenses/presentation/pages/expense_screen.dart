import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/localization/app_localization.dart';
import '../../../../core/widgets/app_drawer.dart';
import '../../../chart/presentation/pages/chart_screen.dart';
import '../../data/models/expense_model.dart';
import '../bloc/expense_bloc.dart';
import '../bloc/expense_event.dart';
import '../bloc/expense_state.dart';
import '../widgets/expense_list.dart';
import '../widgets/new_expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
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
              style: const TextStyle(
                inherit: true,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChartScreen(expenses: expenses),
                    ),
                  );
                },
                icon: const Icon(Icons.pie_chart_rounded),
                tooltip: "Reports",
              ),
            ],
          ),
          drawer: const AppDrawer(),
          body: Column(
            children: [
              // Dashboard Total Balance Card
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
          floatingActionButton: FloatingActionButton.extended(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
            label: Text(context.l10n('add')),
          ),
        );
      },
    );
  }
}
