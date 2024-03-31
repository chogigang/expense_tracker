import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
// 유의점 : 텍스트 편집 컨트롤러를 생성할 때 위젯이 필요없으면 플러터에게 컨트롤러를 지워라고 해야한다 .
  final _titleController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller:
                _titleController, // 택스트 필드의 값이 바뀔 때마다 트리거가 되는 함수 ex 키를 눌러 하나의 함수르 변경하면 문자열 값을 받고 텍스트 필드에 입력함
            maxLength: 50,
            decoration: const InputDecoration(label: Text('Title')),
          ),
          Row(
            children: [
              ElevatedButton(
                  onPressed: () {
                    print(_titleController.text);
                  },
                  child: const Text('Save Expense')),
            ],
          )
        ],
      ),
    );
  }
}
