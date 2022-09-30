import 'package:flutter/material.dart';
import '../api.dart';
import '../widgets/exams.dart';
import '../widgets/api_documentation.dart';
import '../widgets/my_accounts.dart';

class Home extends StatelessWidget {
  Home({super.key});

  final API _api = API.getInstance();

  @override
  Widget build(BuildContext context) {
    final List<Exam> exams = _api.exams;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Ltuc Exams"),
          bottom: const TabBar(
            labelColor: Color(0xffF0F5F9),
            unselectedLabelColor: Colors.grey,
            indicatorColor: Color(0xffF0F5F9),
            tabs: [
              Tab(
                //icon: FaIcon(FontAwesomeIcons.shirt),
                child: Text("Exams"),
              ),
              Tab(
                //icon: FaIcon(FontAwesomeIcons.link),
                child: Text("API Documentation"),
              ),
              Tab(
                //icon: Icon(Icons.person),
                child: Text("My Accounts"),
              ),
            ],
          ),
        ),
        body: FutureBuilder(
          future: _api.getExams(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return TabBarView(
              children: [
                Exams(),
                const ApiDocumentation(),
                MyAccounts(),
              ],
            );
          },
        ),
      ),
    );
  }
}
