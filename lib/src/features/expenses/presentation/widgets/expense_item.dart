// ignore_for_file: non_const_argument_for_const_parameter
import 'package:expensive_tracker_app/common_exports.dart';

class ExpenseItem extends StatelessWidget {
  final Expense expense;

  const ExpenseItem({
    super.key,
    required this.expense,
  });

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = AppTheme().light.primaryColor;
    return Container(
      decoration: BoxDecoration(
        color: primaryColor.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: primaryColor,
          width: 0.4,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(kAppPadding - 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  expense.title,
                  textScaler: TextScaler.noScaling,
                  style: TextStyle(
                    fontSize: 18,
                    color: primaryColor,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: kAppPadding-8),
                Row(
                  children: [
                    Text(
                      expense.amount.toStringAsFixed(2),
                      style: TextStyle(
                        fontSize: 14,
                        color: expense.category.type == TransactionType.income
                            ? Colors.green
                            : Colors.red,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 4),
                    AppIconButton(
                      icon: expense.category.type == TransactionType.income
                          ? Icons.arrow_upward
                          : Icons.arrow_downward_outlined,
                      containerSize: 20,
                      iconSize: 16,
                      color: expense.category.type == TransactionType.income
                          ? Colors.green
                          : Colors.red,
                    ),
                  ],
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  IconData(
                    expense.category.iconCode,
                    fontFamily: 'MaterialIcons',
                  ),
                  color: primaryColor,
                  size: kAppPadding * 2,
                ),
                SizedBox(height: 4),
                Text(
                  expense.formattedDate,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
