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
  final TextEditingController dateController = TextEditingController();

  void presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );

    if (pickDate == null) return;

    setState(() {
      selectDate = pickDate;
      dateController.text = formatter.format(pickDate);
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
    dateController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius:
            const BorderRadius.vertical(top: Radius.circular(kAppBorderRadius)),
      ),
      padding: EdgeInsets.fromLTRB(
        kAppPadding,
        kAppPadding,
        kAppPadding,
        kAppPadding + bottomInset,
      ),
      child: ListView(
        controller: widget.scrollController,
        children: [
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              color: theme.dividerColor.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Text(
            'Add New Expense',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          TextField(
            maxLength: 50,
            controller: titleController,
            textCapitalization: TextCapitalization.sentences,
            onTap: () {
              if (widget.draggableController.isAttached) {
                widget.draggableController.animateTo(
                  0.9,
                  curve: Curves.easeOut,
                  duration: const Duration(milliseconds: 300),
                );
              }
            },
            decoration: const InputDecoration(
              labelText: 'Title',
              hintText: 'e.g. Grocery Shopping',
              prefixIcon: Icon(Icons.title),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: amountController,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  onTap: () {
                    if (widget.draggableController.isAttached) {
                      widget.draggableController.animateTo(
                        0.9,
                        curve: Curves.easeOut,
                        duration: const Duration(milliseconds: 300),
                      );
                    }
                  },
                  decoration: const InputDecoration(
                    labelText: 'Amount',
                    prefixText: '\$ ',
                    prefixIcon: Icon(Icons.attach_money),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TextField(
                  readOnly: true,
                  onTap: presentDatePicker,
                  decoration: InputDecoration(
                    labelText: 'Date',
                    hintText: selectDate == null
                        ? 'Select Date'
                        : formatter.format(selectDate!),
                    prefixIcon: const Icon(Icons.calendar_today),
                    suffixIcon: const Icon(Icons.arrow_drop_down),
                  ),
                  controller: dateController,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<Category>(
            value: selectCategory,
            decoration: const InputDecoration(
              labelText: 'Category',
              prefixIcon: Icon(Icons.category),
            ),
            items: Category.values
                .map(
                  (category) => DropdownMenuItem(
                    value: category,
                    child: Row(
                      children: [
                        Icon(categoryIcons[category], size: 16),
                        const SizedBox(width: 8),
                        Text(category.name.toUpperCase()),
                      ],
                    ),
                  ),
                )
                .toList(),
            onChanged: (value) {
              if (value == null) return;
              setState(() {
                selectCategory = value;
              });
            },
          ),
          const SizedBox(height: 32),
          Row(
            children: [
              Expanded(
                child: SecondaryButton(
                  text: 'Cancel',
                  onTap: () => Navigator.pop(context),
                ),
              ),
              const SizedBox(width: kAppPadding),
              Expanded(
                child: PrimaryButton(
                  text: 'Save Expense',
                  onTap: submitExpenseDate,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
