import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'Flutter Course',
      amount: 19.99,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: 'Cinema',
      amount: 15.69,
      date: DateTime.now(),
      category: Category.leisure,
    ),
  ];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(
        onAddExpense: _addExpense,
      ),
    );
  }

// 항목 추가
  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  //항목 삭제
  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars(); // 새로운 스낵바가 생기면 기존 스낵바 바로 내리고 새로운 스낵바 올리기 
    ScaffoldMessenger.of(context).showSnackBar( //스낵바 보여주기 
      SnackBar(
        duration: const Duration(seconds: 3), //몇초 동안 있을 것인가
        content: const Text('지출 삭제'), // 스낵바가 생성되면서 표시할 메시지
        action: SnackBarAction(
          // 스낵바가 나왔을떼 추가로 할수 있는 엑션
          label: '취소',
          onPressed: () {
            setState(() {
              //삭제를 취소 했으니 삭제했던 요소를 다시 추가
              _registeredExpenses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Text('지출 내역 없음'),
    );

    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpenses,
        onRemoveExpense: _removeExpense,
      );
    }
    ;
    return Scaffold(
      appBar: AppBar(
        title: const Text("flutter ExpenseTracker"),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          const Text('이건 차트 '),
          Expanded(
            child: mainContent,
          ),
        ],
      ),
    );
  }
}
