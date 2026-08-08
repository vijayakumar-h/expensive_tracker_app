// ignore_for_file: non_const_argument_for_const_parameter
import 'package:expensive_tracker_app/src/utils/common_exports.dart';

class NewExpenseScreen extends StatefulWidget {
  final ScrollController scrollController;
  final void Function(Expense expense) onAddExpense;
  final DraggableScrollableController draggableController;
  final Expense? existingExpense;

  const NewExpenseScreen({
    super.key,
    required this.onAddExpense,
    required this.scrollController,
    required this.draggableController,
    this.existingExpense,
  });

  @override
  State<NewExpenseScreen> createState() => _NewExpenseScreenState();
}

class _NewExpenseScreenState extends State<NewExpenseScreen> {
  DateTime? selectDate;
  CategoryModel? selectCategory;
  TransactionType selectedType = TransactionType.expense;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final expenseBloc = context.read<ExpenseBloc>();
    final categories = expenseBloc.state.categories;

    if (widget.existingExpense != null) {
      final e = widget.existingExpense!;
      titleController.text = e.title;
      amountController.text = e.amount.toString();
      selectDate = e.date;
      dateController.text = formatter.format(e.date);
      selectedType = e.type;

      try {
        selectCategory = categories.firstWhere(
          (c) => c.id == e.category.id || c.name == e.category.name,
          orElse: () => e.category,
        );
      } catch (_) {
        selectCategory = e.category;
      }
    } else {
      _updateCategories(categories);
    }
  }

  void _updateCategories(List<CategoryModel> allCategories) {
    final categories = allCategories
        .where((c) => c.type == selectedType)
        .toList();
    if (categories.isNotEmpty) {
      selectCategory = categories.first;
    }
  }

  void presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickDate = await showDatePicker(
      context: context,
      initialDate: selectDate ?? now,
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
        selectDate == null ||
        selectCategory == null) {
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

    final expense = Expense(
      id: widget.existingExpense?.id,
      title: titleController.text,
      amount: enterAmount,
      date: selectDate!,
      category: selectCategory!,
      type: selectedType,
    );

    widget.onAddExpense(expense);
    Navigator.pop(context);
  }

  @override
  void dispose() {
    titleController.dispose();
    amountController.dispose();
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, settingsState) {
        return BlocBuilder<ExpenseBloc, ExpenseState>(
          builder: (context, state) {
            final currentCategories = state.categories
                .where((c) => c.type == selectedType)
                .toList();

            if (currentCategories.isNotEmpty) {
              if (selectCategory == null ||
                  !currentCategories.any((c) => c.id == selectCategory!.id)) {
                selectCategory = currentCategories.first;
              }
            }

            return Container(
              decoration: BoxDecoration(
                color: theme.scaffoldBackgroundColor,
                borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(kAppBorderRadius)),
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
                    widget.existingExpense != null
                        ? context.l10n('edit_transaction')
                        : context.l10n('add_transaction'),
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Center(
                    child: ToggleButtons(
                      borderRadius: BorderRadius.circular(8),
                      isSelected: [
                        selectedType == TransactionType.expense,
                        selectedType == TransactionType.income,
                      ],
                      onPressed: (index) {
                        setState(() {
                          selectedType = index == 0
                              ? TransactionType.expense
                              : TransactionType.income;
                          _updateCategories(state.categories);
                        });
                      },
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Text(context.l10n('expenses')),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Text(context.l10n('income')),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
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
                    decoration: InputDecoration(
                      labelText: context.l10n('title'),
                      hintText: 'e.g. Grocery Shopping',
                      prefixIcon: const Icon(Icons.title),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: amountController,
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          onTap: () {
                            if (widget.draggableController.isAttached) {
                              widget.draggableController.animateTo(
                                0.9,
                                curve: Curves.easeOut,
                                duration: const Duration(milliseconds: 300),
                              );
                            }
                          },
                          decoration: InputDecoration(
                            labelText: context.l10n('amount'),
                            prefixText: '\$ ',
                            prefixIcon: const Icon(Icons.attach_money),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextField(
                          readOnly: true,
                          onTap: presentDatePicker,
                          decoration: InputDecoration(
                            labelText: context.l10n('date'),
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
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<CategoryModel>(
                          initialValue: selectCategory,
                          decoration: InputDecoration(
                            labelText: context.l10n('category'),
                            prefixIcon: const Icon(Icons.category),
                          ),
                          items: currentCategories
                              .map(
                                (category) => DropdownMenuItem(
                                  value: category,
                                  child: Row(
                                    children: [
                                      Icon(
                                          IconData(category.iconCode,
                                              fontFamily: 'MaterialIcons'),
                                          size: 16),
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
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        onPressed: () =>
                            _showAddCategoryDialog(state.categories),
                        icon: const Icon(Icons.add_circle_outline),
                        tooltip: "Add Category",
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  Row(
                    children: [
                      Expanded(
                        child: SecondaryButton(
                          text: context.l10n('cancel'),
                          onTap: () => Navigator.pop(context),
                        ),
                      ),
                      const SizedBox(width: kAppPadding),
                      Expanded(
                        child: PrimaryButton(
                          text: widget.existingExpense != null
                              ? context.l10n('update')
                              : context.l10n('save'),
                          onTap: submitExpenseDate,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showAddCategoryDialog(List<CategoryModel> categories) {
    final nameController = TextEditingController();
    int selectedIconCode = kAvailableIcons.first.codePoint;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('New Category'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Category Name',
                  hintText: 'e.g., Gaming',
                ),
              ),
              const SizedBox(height: 16),
              const Text('Select Icon:'),
              const SizedBox(height: 8),
              SizedBox(
                height: 200,
                width: double.maxFinite,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                  ),
                  itemCount: kAvailableIcons.length,
                  itemBuilder: (context, index) {
                    final icon = kAvailableIcons[index];
                    final isSelected = icon.codePoint == selectedIconCode;
                    return InkWell(
                      onTap: () {
                        setDialogState(() {
                          selectedIconCode = icon.codePoint;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Theme.of(context)
                                  .primaryColor
                                  .withValues(alpha: 0.2)
                              : null,
                          border: isSelected
                              ? Border.all(
                                  color: Theme.of(context).primaryColor)
                              : Border.all(
                                  color: Colors.grey.withValues(alpha: 0.3)),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          icon,
                          color: isSelected
                              ? Theme.of(context).primaryColor
                              : Colors.grey,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (nameController.text.trim().isEmpty) return;

                final newCategory = CategoryModel(
                  name: nameController.text.trim(),
                  iconCode: selectedIconCode,
                  type: selectedType,
                );

                context.read<ExpenseBloc>().add(AddCategoryEvent(newCategory));
                setState(() {
                  selectCategory = newCategory;
                });
                Navigator.pop(ctx);
              },
              child: const Text('Add'),
            ),
          ],
        ),
      ),
    );
  }
}
