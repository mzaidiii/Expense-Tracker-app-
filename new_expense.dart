import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:expence_tracker/models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final titleController = TextEditingController();
  final ammountController = TextEditingController();
  DateTime? selectedDate;
  Catogary selectedCatogary = Catogary.Food;

  void presentDate() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final datePick = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);
    setState(() {
      selectedDate = datePick;
    });
  }

  @override
  void dispose() {
    titleController.dispose();
    ammountController.dispose();
    super.dispose();
  }

  void _submittedUserdata() {
    final enteredAmount = double.tryParse(ammountController.text);
    final invalidAmmount = enteredAmount == null || enteredAmount <= 0;
    if (titleController.text.trim().isEmpty ||
        invalidAmmount ||
        selectedDate == null) {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text("INVALID INPUT "),
                content: const Text(
                  "YOU have entered the invalib input  ",
                  style: TextStyle(color: Colors.red),
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                      },
                      child: const Text("OKAY"))
                ],
              ));
      return;
    }
    widget.onAddExpense(Expense(
        title: titleController.text,
        ammount: enteredAmount,
        date: selectedDate!,
        catogary: selectedCatogary));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final keyBoardlen = MediaQuery.of(context).viewInsets.bottom;
    return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 48, 16, keyBoardlen + 16),
          child: Column(children: [
            TextField(
              controller: titleController,
              maxLength: 50,
              decoration: const InputDecoration(label: Text("Title")),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: ammountController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        prefixText: "₹", label: Text("amount")),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(selectedDate == null
                        ? "No Date Picked "
                        : formatter.format(selectedDate!)),
                    IconButton(
                        onPressed: presentDate,
                        icon: const Icon(Icons.calendar_month))
                  ],
                )),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                DropdownButton(
                  value: selectedCatogary,
                  items: Catogary.values
                      .map(
                        (catogary) => DropdownMenuItem(
                            value: catogary,
                            child: Text(catogary.name.toUpperCase())),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }
                    setState(() {
                      selectedCatogary = value;
                    });
                    print(selectedCatogary);
                  },
                ),
                Spacer(),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("cancle ")),
                ElevatedButton(
                    onPressed: _submittedUserdata,
                    child: const Text("Save expense")),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
