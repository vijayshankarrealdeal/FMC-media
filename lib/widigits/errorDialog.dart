import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const Color colorMain = Color(0xff2b3139);
const Color colorSecondary = Color(0xff7d7d84);
const Color colorThird = Color(0xffffffff);
const Color colorFourth = Color(0xffff286c);
void dialog(BuildContext context, String message) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return Theme(
          data: ThemeData.dark(),
          child: CupertinoAlertDialog(
            title: Text(
              'Error',
              style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 1),
                fontFamily: 'SF-Pro-Text-Semibold',
                fontSize: 17,
              ),
            ),
            content: Text(
              message,
              style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 1),
                fontFamily: 'SF-Pro-Text-Regular',
                fontSize: 13,
              ),
            ),
            actions: [
              CupertinoButton(
                child: Text(
                  'Back',
                  style: TextStyle(
                    color: Color.fromRGBO(255, 69, 58, 1),
                    fontFamily: 'SF-Pro-Text-Regular',
                    fontSize: 17,
                  ),
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        );
      });
}
