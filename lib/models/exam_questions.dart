import 'package:flutter/material.dart';
import '../api.dart';
import './question_choices.dart';
import '../widgets/grade_dialog.dart';

class ExamQuestions extends StatefulWidget {
  final Exam _exam;
  ExamQuestions(this._exam);

  @override
  State<ExamQuestions> createState() => _ExamQuestionsState();
}

class _ExamQuestionsState extends State<ExamQuestions> {
  final PageController _controller = PageController(
    viewportFraction: 1,
    initialPage: 0,
  );
  final ExamAnswers _examAnswers = ExamAnswers.getInstance();

  bool _checkAnswers = false;

  void _giveMeAnswers() {
    setState(() {
      _checkAnswers = true;
    });
  }

  Widget _trueFalseAnswer(int questionIndex,List<Map<String, dynamic>> choices){
    int choiceNum = _examAnswers.asnwers[questionIndex].choiceNum;
    int trueIndex = choices.indexWhere((element) => element['answer'] == true);
    if(choiceNum == trueIndex){
      return const Icon(Icons.done_outline_sharp,color: Colors.green);
    }
    return const Icon(Icons.close,color: Colors.red);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget._exam.getQuestions(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final List<Question> questions = widget._exam.questions;
        return Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: questions.length,
                physics:
                    _checkAnswers ? null : const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  _examAnswers.addAnswer(Answer(questions[index]));
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 50, horizontal: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RichText(
                              text: TextSpan(
                                text: 'Question ${index + 1}',
                                style: Theme.of(context).textTheme.bodyText1,
                                children: const [
                                  TextSpan(
                                    text: ' /15',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if(_checkAnswers)
                              _trueFalseAnswer(index, questions[index].choices)
                          ],
                        ),
                        const Divider(),
                        const SizedBox(
                          height: 20,
                        ),
                        QuestionChoices(questions[index], index, _checkAnswers),
                        const SizedBox(
                          height: 10,
                        ),
                        if (!_checkAnswers)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (index > 0)
                                _elevatedButton('Previous', widget._exam),
                              if (index > 0)
                                const SizedBox(
                                  width: 10,
                                ),
                              if (index != questions.length - 1)
                                _elevatedButton('Next', widget._exam),
                              if (index == questions.length - 1)
                                _elevatedButton('Submit', widget._exam)
                            ],
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
            if (_checkAnswers)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _examAnswers.clearAswers();
                          
                            _checkAnswers = false;
                          });
                        },
                        child: const Text("Done"),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        );
      },
    );
  }

  ElevatedButton _elevatedButton(String title, Exam exam) {
    return ElevatedButton(
      onPressed: () {
        if (title == 'Next') {
          _controller.nextPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.linear,
          );
        } else if (title == 'Previous') {
          _controller.previousPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.linear,
          );
        } else {
          showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                title: const Text("Submit Exam"),
                content: const Text("Are you sure ?"),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                      showDialog(
                        context: context,
                        builder: (ctx) {
                          _examAnswers.evaluateGrade();
                          return GradeDialog(_giveMeAnswers);
                        },
                      );
                    },
                    child: const Text("Yes"),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                    child: const Text("No"),
                  ),
                ],
              );
            },
          );
        }
      },
      child: Text(title),
    );
  }
}
