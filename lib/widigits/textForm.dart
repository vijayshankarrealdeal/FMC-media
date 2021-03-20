import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const Color colorMain = Color(0xff2b3139);
const Color colorSecondary = Color(0xff7d7d84);
const Color colorThird = Color(0xffffffff);
const Color colorFourth = Color(0xffff286c);

class TextForms extends StatelessWidget {
  final String placeholder;
  final bool hide;
  final TextEditingController enter;
  final double left;
  final double right;
  final bool isspin;
  final bool moveUP;
  TextForms(
      {@required this.placeholder,
      this.left = 10,
      this.right = 10,
      @required this.hide,
      this.isspin = true,
      this.moveUP = false,
      @required this.enter});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.065,
      child: Padding(
        padding: EdgeInsets.only(left: left, right: right),
        child: CupertinoTextField(
          autofocus: moveUP,
          enabled: isspin,
          style: TextStyle(color: Color.fromRGBO(0, 0, 0, 1)),
          decoration: BoxDecoration(
              color: Color.fromRGBO(118, 118, 118, 0.12),
              borderRadius: BorderRadius.circular(5.0)),
          placeholderStyle: TextStyle(
            color: Color.fromRGBO(60, 60, 67, 0.60),
          ),
          controller: enter,
          obscureText: hide,
          placeholder: placeholder,
          prefix: SizedBox(height: 5.0),
        ),
      ),
    );
  }
}
