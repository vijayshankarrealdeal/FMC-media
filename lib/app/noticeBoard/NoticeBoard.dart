import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fmc/model/notification.dart';
import 'package:fmc/services/database.dart';
import 'package:provider/provider.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';

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
    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
    );

    final not = Provider.of<List<Notificationxx>>(context);
    return Scaffold(
      backgroundColor: CupertinoColors.black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromRGBO(29, 29, 29, 1),
        title: Text(
          'Notifications',
          style: TextStyle(
            fontFamily: 'SF-Pro-Display-Bold',
            fontSize: 34,
            color: Color.fromRGBO(255, 255, 255, 1),
          ),
        ),
      ),
      body: not == null
          ? Center(child: CupertinoActivityIndicator())
          : Container(
              child: ListView.builder(
                  itemCount: not.length,
                  itemBuilder: (context, i) {
                    return
                      Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: ExpansionTileCard(
                        leading: CircleAvatar(
                            backgroundColor:not[i].isEventOver? CupertinoColors.activeGreen:CupertinoColors.systemRed,
                            child: Icon(not[i].isEventOver ?CupertinoIcons.checkmark:CupertinoIcons.clear,color:CupertinoColors.white)),
                        title: Text(not[i].title),
                        subtitle: Text(not[i].subTitle),
                        children: <Widget>[
                          Divider(
                            thickness: 1.0,
                            height: 1.0,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 8.0,
                              ),
                              child: Text(
                                not[i].details,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    .copyWith(fontSize: 16),
                              ),
                            ),
                          ),
                        ],
                      ),


                      //
                      // Container(
                      //   height: MediaQuery.of(context).size.height * 0.34,
                      //   decoration: BoxDecoration(
                      //     color: Color.fromRGBO(38, 38, 41, 1),
                      //     borderRadius: BorderRadius.circular(12.0),
                      //   ),
                      //   child: Padding(
                      //     padding: const EdgeInsets.all(8.0),
                      //     child: Column(
                      //       children: [
                      //         Text(
                      //           not[i].title,
                      //           style: TextStyle(
                      //             color: Color.fromRGBO(255, 255, 255, 1),
                      //             fontFamily: 'SF-Pro-Display-Bold',
                      //             fontSize: 28.0,
                      //           ),
                      //         ),
                      //         SizedBox(height: 10),
                      //         Text(
                      //           not[i].subTitle,
                      //           style: TextStyle(
                      //             color: Color.fromRGBO(255, 255, 255, 1),
                      //             fontFamily: 'SF-Pro-Text-Semibold',
                      //             fontSize: 17.0,
                      //           ),
                      //         ),
                      //         SizedBox(height: 10),
                      //         Text(
                      //           not[i].details,
                      //           style: TextStyle(
                      //             color: Color.fromRGBO(255, 255, 255, 1),
                      //             fontFamily: 'SF-Pro-Text-Regular',
                      //             fontSize: 17.0,
                      //           ),
                      //         ),
                      //         SizedBox(height: 10),
                      //         Text(
                      //           not[i].deadLine,
                      //           style: TextStyle(
                      //             color: Color.fromRGBO(255, 255, 255, 1),
                      //             fontFamily: 'SF-Pro-Display-Bold',
                      //             fontSize: 28.0,
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                    );
                  }),
            ),
    );
  }
}
