import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Account extends StatefulWidget {
  final Map<String, dynamic> _accountData;
  final Function _function;
  Account(this._accountData,this._function);

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => widget._function(widget._accountData['url']),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: widget._accountData['main_color']),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget._accountData['title'],
              style: Theme.of(context).textTheme.bodyText1!.copyWith(color: const Color(0xff1E2022))
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: widget._accountData['second_color']),
                child: widget._accountData['icon'],
              ),
            ),
          ],
        ),
      ),
    );
  }
}