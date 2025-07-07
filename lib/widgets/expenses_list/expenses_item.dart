import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expense, {super.key});

  final Expense expense;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, //가로축 정렬
          children: [
            Text(
              expense.title,
              style: Theme.of(context).textTheme.titleLarge,
            ), //main에서 설정한 titleLarge 에 설정된 설정을 불러온다.
            const SizedBox(height: 4),
            Row(
              children: [
                Text(
                    '\$${expense.amount.toStringAsFixed(2)}'), // 뒤에 숫자를 2자리로 제한
                const Spacer(), // 공간을 만들어주는 위젯 항상 남는공간을 다 차지함
                Row(
                  children: [
                    Icon(categoryIcons[expense.category]),
                    const SizedBox(width: 8),
                    Text(expense.formattedDate),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
