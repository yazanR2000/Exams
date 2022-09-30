import 'package:exams/api.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ExamItem extends StatelessWidget {
  final Exam _exam;
  final Color _color;
  ExamItem(this._exam, this._color);

  Widget _checkSubject(String title) {
    if (title == 'English') {
      return Image.asset(
        'images/English_Academy.png',
        width: 80,
        height: 60,
      );
    } else if (title == 'Flutter') {
      return const FlutterLogo(
        size: 50,
      );
    }
    return const FaIcon(
      FontAwesomeIcons.code,
      size: 50,
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .pushNamed('/selected_item_exam', arguments: _exam);
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.only(bottom: 20),
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          //color: _color,
          gradient: LinearGradient(
            colors: [
              _color,
              _color.withOpacity(0.6),
            ],
          ),
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: _checkSubject(_exam.subject),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey.shade300,
                    ),
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed('/selected_item_exam', arguments: _exam);
                      },
                      icon: const FaIcon(
                        FontAwesomeIcons.play,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title: Text(_exam.subject),
                      subtitle: const Text("15 question"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
