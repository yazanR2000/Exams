import 'package:flutter/material.dart';

class ApiDocumentation extends StatefulWidget {
  const ApiDocumentation({super.key});

  @override
  State<ApiDocumentation> createState() => _ApiDocumentationState();
}

class _ApiDocumentationState extends State<ApiDocumentation> {
  int _expandedIndex = -1;
  final List<Map<String, dynamic>> _requests = [
    {
      'title': 'Get Exams',
      'subtitle': 'https://ltuc-exams-default-rtdb.firebaseio.com/Exams.json',
      'example': 'images/get_exams.png'
    },
    {
      'title': 'Get Exam Questions',
      'subtitle':
          'https://ltuc-exams-default-rtdb.firebaseio.com/English/Questions.json',
      'example': 'images/get_questions.png'
    },
    {
      'title': 'Get Question Choices',
      'subtitle':
          'https://ltuc-exams-default-rtdb.firebaseio.com/English/Choices/1.json',
      'example': 'images/get_choices.png'
    },
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _requests.length,
      itemBuilder: (context, index) {
        return _apiRequest(
            _requests[index]['title'],_requests[index]['subtitle'], _requests[index]['example'], index);
      },
    );
  }

  Column _apiRequest(String title,String subtitle, String example, int index) {
    return Column(
      children: [
        ListTile(
          onTap: () {
            setState(() {
              _expandedIndex = _expandedIndex == index ? -1 : index;
            });
          },
          dense: true,
          leading: const Text(
            "GET",
            style: TextStyle(
              color: Colors.green,
            ),
          ),
          title: Text(
            title,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          subtitle: Text(subtitle,style: const TextStyle(color: Colors.grey),),
          trailing: _expandedIndex == index
              ? const Icon(
                  Icons.arrow_drop_up_sharp,
                  color: Color(0xffF0F5F9),
                )
              : const Icon(
                  Icons.arrow_drop_down_sharp,
                  color: Color(0xffF0F5F9),
                ),
        ),
        if (_expandedIndex == index)
          const SizedBox(
            height: 10,
          ),
        if (_expandedIndex == index)
          Container(
            height: 200,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(example),
              ),
            ),
          ),
        if (index != _requests.length - 1) const Divider(),
      ],
    );
  }
}
