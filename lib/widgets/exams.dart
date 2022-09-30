import 'package:flutter/material.dart';
import '../api.dart';
import '../models/exam_item.dart';

class Exams extends StatefulWidget {
  @override
  State<Exams> createState() => _ExamsState();
}

class _ExamsState extends State<Exams> {
  final API _api = API.getInstance();

  List<Exam>? _exams;
  @override
  void initState() {
    super.initState();
    _exams = _api.exams;
  }

  final List<Color> _colors = const [
    Color(0xffF4F9F9),
    Color(0xffCCF2F4),
    Color(0xffA4EBF3),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(25),
      itemCount: _exams!.length,
      itemBuilder: (context, index) {
        return ExamItem(_exams![index], _colors[index % _colors.length]);
      },
    );
  }
}
