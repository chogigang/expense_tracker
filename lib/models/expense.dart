import 'package:expense_tracker/widgets/expenses.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

const uuid = Uuid();

enum Category { food, travel, leisure, work }

const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
};

class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get formattedDate {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  const ExpenseBucket({required this.category, required this.expenses});
  final Category category;
  final List<Expense> expenses;

  ExpenseBucket.forCategory(List<Expense> allExpenses,
      this.category) //일반 생성자가 아닌 이름있는 생성자  .forCategory.   List<Expense> allExpenses 모든 지출 내역이 있는 전체 목록
      : expenses =
            allExpenses // : 는 해당 생성자의 핵심 초기화 목록 (Initializer List)    expenses = allExpenses -> 모든 지출 내역을 하나씩 검토한다.
                .where((expense) =>
                    expense.category ==
                    category) // where 특정 조건에 맞는 항목만 골라낸다.  expense.category == category 같으면 리스트로 변환
                .toList();

  double get totalExpenses {
    double sum = 0;
    for (final expense in expenses) {
      sum += expense.amount;
    }

    return sum;
  }
}
