import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  final String loadMessage;

  const Loading({Key key, this.loadMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              loadMessage,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(
              height: 24,
            ),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.lightGreen),
            ),
          ],
        ));
  }
}