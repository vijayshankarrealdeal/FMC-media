import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fmc/login/validation.dart';
import 'package:fmc/services/auth.dart';
import 'package:fmc/widigits/errorDialog.dart';
import 'package:fmc/widigits/textForm.dart';
import 'package:provider/provider.dart';

enum LoginLogics { signIn, signUp, forgetPass }

class LoginSign extends StatefulWidget {
  @override
  _LoginSignState createState() => _LoginSignState();
}

class _LoginSignState extends State<LoginSign> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _confirmpassword = TextEditingController();

  ///
  String get email => _email.text;
  String get password => _password.text;
  String get confirmPassword => _confirmpassword.text;
  bool isSpin = true;

  ///

  LoginLogics _formType = LoginLogics.signIn;
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context);
    String primaryText = _formType == LoginLogics.signIn ? 'Log In' : 'Sign up';
    String secondaryText = _formType == LoginLogics.signIn
        ? 'Don\'t Have a account'
        : 'Have a account';
    return Scaffold(
      backgroundColor: CupertinoColors.black,
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.25,
                ),
                Column(
                  children: [
                    Text(
                      'FMC',
                      style: TextStyle(
                        fontFamily: 'SF-Pro-Display-Bold',
                        fontSize: 60,
                        color: Color.fromRGBO(255, 255, 255, 1),
                      ),
                    ),
                    // Text(
                    //   'Indian Institute of Information Technology Kalyani',
                    //   style: TextStyle(
                    //     fontFamily: 'SF-Pro-Display-Bold',
                    //     fontSize: 15,
                    //     color: Color.fromRGBO(255, 255, 255, 1),
                    //   ),
                    // ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                TextForms(
                  enter: _email,
                  placeholder: 'Email Address',
                  isspin: isSpin,
                  hide: false,
                ),
                SizedBox(height: 5),
                TextForms(
                  enter: _password,
                  placeholder: 'Password',
                  isspin: isSpin,
                  hide: true,
                ),
                SizedBox(height: 5),
                _formType == LoginLogics.signUp
                    ? TextForms(
                        enter: _confirmpassword,
                        placeholder: 'Confirm Password',
                        isspin: isSpin,
                        hide: true,
                      )
                    : SizedBox(
                        height: 0,
                      ),
                SizedBox(height: 20),
                isSpin
                    ? CupertinoButton(
                        color: Color.fromRGBO(255, 69, 58, 1),
                        child: Text(primaryText),
                        onPressed: () async {
                          if (_formType == LoginLogics.signIn) {
                            setState(() {
                              isSpin = false;
                            });
                            try {
                              checkValidity(email, password, '', true);
                              await auth.signInEmailandPassword(
                                  email, password);
                              setState(() {
                                isSpin = true;
                              });
                            } catch (e) {
                              setState(() {
                                isSpin = true;
                              });
                              dialog(context, e.message);
                              print(e.message);
                            }
                          } else {
                            try {
                              checkValidity(
                                  email, password, confirmPassword, false);
                              await auth.createEmailandPassword(
                                  email, password);
                            } catch (e) {
                              dialog(context, e.message);
                              print(e.message);
                            }
                          }
                        })
                    : CupertinoActivityIndicator(),
                CupertinoButton(
                    child: Text(
                      secondaryText,
                      style: TextStyle(color: Colors.red),
                    ),
                    onPressed: () {
                      setState(() {
                        _formType = _formType == LoginLogics.signIn
                            ? LoginLogics.signUp
                            : LoginLogics.signIn;
                      });
                    }),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
