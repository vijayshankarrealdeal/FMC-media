import 'package:flutter/material.dart';

class NoticeBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromRGBO(255, 255, 255, 1),
        title: Text(
          'Notifications',
          style: TextStyle(
            fontFamily: 'SF-Pro-Display-Bold',
            fontSize: 34,
            color: Color.fromRGBO(0, 0, 0, 1),
          ),
        ),
      ),
      body: Container(
        color: Colors.amber,
      ),
    );
  }
}
