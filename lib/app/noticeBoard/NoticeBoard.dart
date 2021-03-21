import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fmc/model/notification.dart';
import 'package:fmc/services/database.dart';
import 'package:provider/provider.dart';

class NoticeBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final d = Provider.of<Database>(context);
    return MultiProvider(
      providers: [
        StreamProvider.value(value: d.noticf(), initialData: null),
      ],
      child: NoticeBoardExtended(),
    );
  }
}

class NoticeBoardExtended extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final not = Provider.of<List<Notificationxx>>(context);
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
      body: not == null
          ? Center(child: CircularProgressIndicator())
          : Container(
              child: ListView.builder(
                  itemCount: not.length,
                  itemBuilder: (context, i) {
                    return Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.2,
                        decoration: BoxDecoration(
                          color: CupertinoColors.white,
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Column(
                          children: [
                            Text(not[i].title),
                            Text(not[i].subTitle),
                            Text(not[i].details),
                            Text(not[i].deadLine),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
    );
  }
}
