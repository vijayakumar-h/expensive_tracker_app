import 'package:expensive_tracker_app/utils/common_exports.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList({
    super.key,
    required this.expenses,
    required this.onRemoveExpense,
    required this.onEditExpense,
  });

  final List<Expense> expenses;
  final void Function(Expense expense) onRemoveExpense;
  final void Function(Expense expense) onEditExpense;

  @override
  Widget build(BuildContext context) => ListView.builder(
        shrinkWrap: true,
        itemCount: expenses.length,
        padding: EdgeInsets.symmetric(
          horizontal: kAppPadding,
          vertical: kAppPadding,
        ),
        itemBuilder: (context, index) => Dismissible(
          onDismissed: (direction) {
            onRemoveExpense(expenses[index]);
          },
          background: Card(
            color: Colors.red,
            margin: EdgeInsets.zero,
          ),
          key: ValueKey(expenses[index]),
          child: InkWell(
            onTap: () => onEditExpense(expenses[index]),
            child: ExpenseItem(
              expense: expenses[index],
            ),
          ),
        ),
      );
}
