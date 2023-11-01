import 'package:expensive_tracker_app/utils/common_exports.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList({super.key, required this.expenses});

  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
        itemCount: expenses.length,
        itemBuilder: (context, index) {
          return Text(expenses[index].title);
        });
  }
}
