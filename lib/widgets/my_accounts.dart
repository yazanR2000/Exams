import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/account.dart';
import 'package:url_launcher/url_launcher.dart';

class MyAccounts extends StatefulWidget {
  MyAccounts({super.key});

  @override
  State<MyAccounts> createState() => _MyAccountsState();
}

class _MyAccountsState extends State<MyAccounts> {
  final Map<String, Map<String, dynamic>> _myAccounts = {
    "Facebook": {
      "title": "Facebook",
      "url": Uri.parse("https://www.facebook.com/yazan.rami.5496"),
      "main_color": const Color(0xffF0F5F9),
      "second_color": Colors.white,
      "icon": const FaIcon(
        FontAwesomeIcons.facebook,
        color: Colors.black,
      ),
    },
    "Instagram": {
      "title": "Instagram",
      "url": Uri.parse("https://www.instagram.com/radaideh_yazan/"),
      "main_color": const Color(0xffCCF2F4),
      "second_color": Colors.white,
      "icon": const FaIcon(
        FontAwesomeIcons.instagram,
        color: Colors.black,
      ),
    },
    "GitHub": {
      "title": "GitHub",
      "url": Uri.parse("https://github.com/yazanR2000"),
      "main_color": const Color(0xffA4EBF3),
      "second_color": Colors.white,
      "icon": const FaIcon(
        FontAwesomeIcons.github,
        color: Colors.black,
      ),
    },
    "Linkedin": {
      "title": "Linkedin",
      "url": Uri.parse("https://www.linkedin.com/in/yazan-radaideh-3805b4201/"),
      "main_color": const Color(0xffAAAAAA),
      "second_color": Colors.white,
      "icon": const FaIcon(
        FontAwesomeIcons.linkedin,
        color: Colors.black,
      ),
    },
  };

  Future _urlLunch(Uri url) async {
    try {
      setState(() {
        _isLoading = true;
      });
      await launchUrl(url);
      setState(() {
        _isLoading = false;
      });
    } catch (err) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Could not launch $url',
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: GridView(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    children: [
                      Account(_myAccounts['Facebook']!, _urlLunch),
                      Account(_myAccounts['Instagram']!, _urlLunch),
                      Account(_myAccounts['GitHub']!, _urlLunch),
                      Account(_myAccounts['Linkedin']!, _urlLunch),
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}