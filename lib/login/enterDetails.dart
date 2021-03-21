import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fmc/model/studentDetail.dart';
import 'package:fmc/services/auth.dart';
import 'package:fmc/services/database.dart';
import 'package:fmc/widigits/errorDialog.dart';
import 'package:fmc/widigits/textForm.dart';

class EnterDetailsPage extends StatefulWidget {
  final StudentDetails data;
  final Database database;
  final Auth auth;
  EnterDetailsPage({Key key, this.auth, this.database, this.data})
      : super(key: key);

  @override
  _EnterDetailsPageState createState() => _EnterDetailsPageState();
}

class _EnterDetailsPageState extends State<EnterDetailsPage> {
  String dateTimeX = '';
  bool male = false;
  String gender = 'Female';
  TextEditingController _name = TextEditingController();
  String get name => _name.text;
  Timer timer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(
                18.0,
              ),
              child: Column(
                children: [
                  Container(width: double.infinity),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 18.0, left: 18.0, right: 18.0, bottom: 35.0),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: CupertinoButton(
                          color: CupertinoColors.systemRed,
                          child: Text('Logout'),
                          onPressed: () async {
                            await widget.auth.signOut();
                          }),
                    ),
                  ),
                  TextForms(placeholder: 'Name', hide: false, enter: _name),
                  SizedBox(height: 25),
                  Text(
                    'Select BirthDate',
                    style: TextStyle(
                      fontFamily: 'SF-Pro-Display-Bold',
                      fontSize: 20,
                      color: Color.fromRGBO(255, 255, 255, 1),
                    ),
                  ),
                  Container(
                    color: Color.fromRGBO(118, 118, 118, 0.24),
                    height: MediaQuery.of(context).size.height * 0.15,
                    child: CupertinoDatePicker(
                      mode: CupertinoDatePickerMode.date,
                      onDateTimeChanged: (DateTime dateTime) {
                        dateTimeX = dateTime.toString();
                      },
                    ),
                  ),
                  SizedBox(height: 25),
                  Text(
                    gender,
                    style: TextStyle(
                      fontFamily: 'SF-Pro-Display-Bold',
                      fontSize: 20,
                      color: Color.fromRGBO(255, 255, 255, 1),
                    ),
                  ),
                  CupertinoSwitch(
                    value: male,
                    onChanged: (value) {
                      setState(() {
                        male = !male;
                        male ? gender = 'Male' : gender = 'Female';
                      });
                    },
                  ),
                  SizedBox(height: 25),
                  Text(
                    'if you verified with email click on Refresh',
                    style: TextStyle(
                      fontFamily: 'SF-Pro-Display-Bold',
                      fontSize: 16,
                      color: Color.fromRGBO(255, 255, 255, 1),
                    ),
                  ),
                  IconButton(
                      icon: Icon(
                        Icons.refresh,
                        color: Color.fromRGBO(255, 255, 255, 0.84),
                      ),
                      onPressed: () {
                        widget.auth.reloadUserStatus();
                      }),
                  widget.auth.verifiedUser
                      ? CupertinoButton(
                          color: CupertinoColors.systemRed,
                          child: Text('Submit'),
                          onPressed: () async {
                            if (name.isEmpty) {
                              throw Exception('Enter Your name');
                            }
                            if (!widget.auth.verifiedUser) {
                              throw Exception('Verify Your Email');
                            }
                            try {
                              StudentDetails data = StudentDetails(
                                dob: dateTimeX,
                                firstTime: true,
                                name: name,
                                uid: widget.database.uid,
                                gender: gender,
                                email: widget.database.email,
                              );
                              await widget.database.createStudent(data);
                            } catch (e) {
                              dialog(context, e.message);
                            }
                          })
                      : CupertinoButton(
                          color: CupertinoColors.systemRed,
                          child: Text('Verify First'),
                          onPressed: () async {
                            widget.auth.verifyEmail();
                            print('pressed');
                          }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
