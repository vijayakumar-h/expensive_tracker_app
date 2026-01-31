import 'package:expensive_tracker_app/utils/common_exports.dart';

class NewExpenseScreen extends StatefulWidget {
  final ScrollController scrollController;
  final void Function(Expense expense) onAddExpense;
  final DraggableScrollableController draggableController;

  const NewExpenseScreen({
    super.key,
    required this.onAddExpense,
    required this.scrollController,
    required this.draggableController,
  });

  @override
  State<NewExpenseScreen> createState() => _NewExpenseScreenState();
}

class _NewExpenseScreenState extends State<NewExpenseScreen> {
  DateTime? selectDate;
  Category selectCategory = Category.food;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  void presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );
    setState(() {
      selectDate = pickDate;
    });
  }

  void submitExpenseDate() {
    final enterAmount = double.tryParse(amountController.text);
    final amountIsInvalid = enterAmount == null || enterAmount <= 0;
    if (titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        selectDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Invalid Text"),
          content: const Text(
              "Please make sure a valid title, amount, date and category was entered"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text("Okay"),
            ),
          ],
        ),
      );
      return;
    }
    widget.onAddExpense(
      Expense(
        title: titleController.text,
        amount: enterAmount,
        date: selectDate!,
        category: selectCategory,
      ),
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    amountController.dispose();
  }

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(kAppPadding),
        child: ListView(
          controller: widget.scrollController,
          children: [
            TextField(
              maxLength: 50,
              controller: titleController,
              onTap: () => widget.draggableController.animateTo(
                0.75,
                curve: Curves.easeOut,
                duration: const Duration(milliseconds: 300),
              ),
              decoration: const InputDecoration(
                label: Text('Title'),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    onTap: () => widget.draggableController.animateTo(
                      0.75,
                      curve: Curves.easeOut,
                      duration: const Duration(milliseconds: 300),
                    ),
                    controller: amountController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      prefixText: '\$',
                      label: Text("Amount"),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        selectDate == null
                            ? "No data found"
                            : formatter.format(selectDate!),
                      ),
                      IconButton(
                        onPressed: presentDatePicker,
                        icon: const Icon(
                          Icons.calendar_month,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                DropdownButton(
                    value: selectCategory,
                    items: Category.values
                        .map(
                          (category) => DropdownMenuItem(
                            value: category,
                            child: Text(
                              category.name.toUpperCase(),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      if (value == null) {
                        return;
                      }
                      setState(() {
                        selectCategory = value;
                      });
                    }),
                const Spacer(),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: SecondaryButton(
                    text: 'Cancel',
                    onTap: () => Navigator.pop(context),
                  ),
                ),
                SizedBox(width: kAppPadding),
                Expanded(
                  child: PrimaryButton(
                    text: 'Save Expenses',
                    onTap: submitExpenseDate,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
}
