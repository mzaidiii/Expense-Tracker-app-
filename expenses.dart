import 'package:expence_tracker/widgets/chart/chart.dart';
import 'package:expence_tracker/widgets/expence/expenses_list.dart';
import 'package:expence_tracker/models/expense.dart';
import 'package:expence_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _rejisteredExpense = [
    Expense(
        title: 'flutter course ',
        ammount: 4000.00,
        date: DateTime.now(),
        catogary: Catogary.personal),
    Expense(
        title: 'Cinema',
        ammount: 500.00,
        date: DateTime.now(),
        catogary: Catogary.leisure),
  ];

  void _OpenAddExpensesOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(onAddExpense: _addExpense),
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _rejisteredExpense.add(expense);
    });
  }

  void removeExpense(Expense expense) {
    final deleteindex = _rejisteredExpense.indexOf(expense);
    setState(() {
      _rejisteredExpense.remove(expense);
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 3),
      content: const Text("Expense item Deleted"),
      action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _rejisteredExpense.insert(deleteindex, expense);
            });
          }),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    Widget mainContent = const Center(
      child: Text("No expense is found! add soem expense...!"),
    );

    if (_rejisteredExpense.isNotEmpty) {
      mainContent = ExpenseList(
        expenses: _rejisteredExpense,
        removeditem: removeExpense,
      );
    }
    return Scaffold(
      appBar: AppBar(title: const Text("Add your expense"), actions: [
        IconButton(
            onPressed: _OpenAddExpensesOverlay, icon: const Icon(Icons.add))
      ]),
      body: width < 600
          ? Column(
              children: [
                Chart(expenses: _rejisteredExpense),
                Expanded(
                  child: mainContent,
                )
              ],
            )
          : Row(
              children: [
                Expanded(child: Chart(expenses: _rejisteredExpense)),
                Expanded(
                  child: mainContent,
                )
              ],
            ),
    );
  }
}
