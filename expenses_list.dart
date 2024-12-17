import 'package:expence_tracker/models/expense.dart';
import 'package:expence_tracker/widgets/expence/expense_item.dart';
import 'package:flutter/material.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList({
    super.key,
    required this.expenses,
    required this.removeditem,
  });

  final List<Expense> expenses;
  final void Function(Expense expence) removeditem;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (context, index) => Dismissible(
              key: ValueKey(expenses[index]),
              background: Container(
                  color: Theme.of(context).colorScheme.error,
                  margin: Theme.of(context).cardTheme.margin),
              onDismissed: (direction) {
                removeditem(expenses[index]);
              },
              child: ExpenseItem(expenses[index]),
            ));
  }
}
