import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fmc/app/mainScreen.dart';
import 'package:fmc/app/navigation/navigationlogic.dart';
import 'package:fmc/login/enterDetails.dart';
import 'package:fmc/login/login.dart';
import 'package:fmc/model/studentDetail.dart';
import 'package:fmc/services/auth.dart';
import 'package:fmc/services/database.dart';
import 'package:provider/provider.dart';

void main() async {
  Provider.debugCheckInvalidValueType = null;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Auth(),
        ),
        ChangeNotifierProvider(
          create: (context) => ChangeofPage(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    final auth = Provider.of<Auth>(context);
    return StreamBuilder<Object>(
        stream: auth.onAuthChange,
        builder: (context, snapshot) {
          User user = snapshot.data;
          if (snapshot.connectionState == ConnectionState.active) {
            if (user == null) {
              return MaterialApp(

                  home: LoginSign());
            } else {
              return MultiProvider(
                  providers: [
                    ChangeNotifierProvider(
                      create: (context) => User(
                        uid: user.uid,
                        email: user.email,
                      ),
                    ),
                    ChangeNotifierProvider(
                      create: (context) =>
                          Database(uid: user.uid, email: user.email),
                    ),
                  ],
                  child: MaterialApp(
                      debugShowCheckedModeBanner: false,
                      home: DessionTree(uid: user.uid)));
            }
          } else {
            return Center(
              child: CupertinoActivityIndicator(),
            );
          }
        });
  }
}

class DessionTree extends StatelessWidget {
  final String uid;

  const DessionTree({Key key, this.uid}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<Database>(context);
    final auth = Provider.of<Auth>(context);
    return StreamBuilder<List<StudentDetails>>(
        stream: data.studentallDetails(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            StudentDetails details;
            if (snapshot.data.any((element) => element.uid == data.uid)) {
              snapshot.data.forEach((element) {
                if (element.uid == data.uid) {
                  details = element;
                }
              });
              return Provider(
                  create: (context) => details, child: MainScreen());
            } else {
              return EnterDetailsPage(
                database: data,
                auth: auth,
              );
            }
          } else {
            return Center(
                child: Container(
                    height: double.infinity,
                    color: CupertinoColors.darkBackgroundGray,
                    child: Center(
                      child: CupertinoActivityIndicator(),
                    )));
          }
        });
  }
}
