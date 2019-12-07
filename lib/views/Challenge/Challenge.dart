import 'package:flutter/material.dart';

class Challenge extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Column(
                children: <Widget>[
                  Text("Code Name"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
