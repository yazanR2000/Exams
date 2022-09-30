import 'package:flutter/material.dart';
import '../api.dart';

class GradeDialog extends StatelessWidget {
  final Function _checkAnswers;
  GradeDialog(this._checkAnswers);
  final ExamAnswers _examAnswers = ExamAnswers.getInstance();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        height: 200,
        child: Column(
          children: [
            Expanded(
              child: Image.asset(
                'images/Congratulations.gif',
                fit: BoxFit.fill,
              ),
            ),
            const Text("Your grade is"),
            Text("${_examAnswers.grade}/15"),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: (){
            Navigator.of(context).pop();
            _checkAnswers();
          },
          child: const Text("Check anwers"),
        ),
      ],
    );
  }
}
