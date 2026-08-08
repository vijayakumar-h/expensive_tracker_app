import 'package:expensive_tracker_app/common_exports.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList({
    super.key,
    required this.expenses,
  });

  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) {
        final expense = expenses[index];
        return Dismissible(
          key: ValueKey(expense.id),
          background: Container(
            color: Theme.of(context).colorScheme.error.withValues(alpha: 0.75),
            margin: EdgeInsets.symmetric(
              horizontal: Theme.of(context).cardTheme.margin?.horizontal ?? 0,
            ),
          ),
          onDismissed: (direction) {
            final expenseBloc = context.read<ExpenseBloc>();
            expenseBloc.add(DeleteExpenseEvent(expense.id));

            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                duration: const Duration(seconds: 3),
                content: Text(context.l10n('expense_deleted')),
                action: SnackBarAction(
                  label: context.l10n('undo'),
                  onPressed: () {
                    expenseBloc.add(AddExpenseEvent(expense));
                  },
                ),
              ),
            );
          },
          child: InkWell(
            onTap: () {
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
                      existingExpense: expense,
                      onAddExpense: (updatedExpense) {
                        context
                            .read<ExpenseBloc>()
                            .add(AddExpenseEvent(updatedExpense));
                      },
                      scrollController: scrollController,
                      draggableController: DraggableScrollableController(),
                    );
                  },
                ),
              );
            },
            child: ExpenseItem(expense: expense),
          ),
        );
      },
    );
  }
}
