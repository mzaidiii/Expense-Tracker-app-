import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final uuid = const Uuid();
final formatter = DateFormat.yMd();

enum Catogary { Food, travel, leisure, personal }

const catogaryIcon = {
  Catogary.Food: Icons.lunch_dining,
  Catogary.travel: Icons.flight_takeoff,
  Catogary.leisure: Icons.movie,
  Catogary.personal: Icons.work
};

class Expense {
  Expense(
      {required this.title,
      required this.ammount,
      required this.date,
      required this.catogary})
      : id = uuid.v4();

  final String id;
  final double ammount;
  final DateTime date;
  final String title;
  final Catogary catogary;
  get formattedDate {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  const ExpenseBucket({
    required this.catogary,
    required this.expense,
  });
  ExpenseBucket.forCatogary(List<Expense> allExpense, this.catogary)
      : expense = allExpense
            .where((expense) => expense.catogary == catogary)
            .toList();
  final Catogary catogary;
  final List<Expense> expense;
  double get totleExpense {
    double sum = 0;
    for (final expenses in expense) {
      sum += expenses.ammount;
    }
    return sum;
  }
}
