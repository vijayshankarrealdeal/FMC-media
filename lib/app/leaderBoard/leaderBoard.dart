import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fmc/app/leaderBoard/state.dart';
import 'package:fmc/model/leaderBoardModel.dart';
import 'package:fmc/model/likes.dart';
import 'package:fmc/model/searchMatchUser.dart';
import 'package:fmc/services/database.dart';
import 'package:provider/provider.dart';

class LeaderBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final db = Provider.of<Database>(context);
    return MultiProvider(
      providers: [
        StreamProvider.value(value: db.leader(), initialData: null),
      ],
      child: LeaderBoardExtends(),
    );
  }
}

class LeaderBoardExtends extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final db = Provider.of<Database>(context);

    final df = Provider.of<List<LeaderBoardModel>>(context);
    return Scaffold(
      backgroundColor: CupertinoColors.black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromRGBO(29, 29, 29, 1),
        title: Text(
          'Home',
          style: TextStyle(
            fontFamily: 'SF-Pro-Display-Bold',
            fontSize: 34,
            color: Color.fromRGBO(255, 255, 255, 1),
          ),
        ),
      ),
      body: df == null
          ? Center(child: CircularProgressIndicator())
          : Container(
              margin: EdgeInsets.only(top: 18.0),
              child: ListView.builder(
                  itemCount: df.length,
                  itemBuilder: (context, i) {
                    return MultiProvider(
                      providers: [
                        ChangeNotifierProvider<StateHearShowS>(
                            create: (context) => StateHearShowS()),
                        StreamProvider<List<SearchAndMatchUser>>.value(
                            value: db.filterStudent(df[i].uid),
                            initialData: null),
                        StreamProvider<List<Likes>>.value(
                            value: db.getLikes(df[i].imagesId),
                            initialData: null),
                      ],
                      child: UIEXS(
                        df: df[i],
                      ),
                    );
                  })),
    );
  }
}

class UIEXS extends StatelessWidget {
  final LeaderBoardModel df;
  const UIEXS({Key key, this.df}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final dsf = Provider.of<List<SearchAndMatchUser>>(context);
    final likes = Provider.of<List<Likes>>(context);
    final db = Provider.of<Database>(context);
    final derr = Provider.of<StateHearShowS>(context);

    return dsf == null
        ? Center(child: CircularProgressIndicator())
        : likes == null
            ? Center(child: CircularProgressIndicator())
            : GestureDetector(
                onDoubleTap: () async {
                  derr.show();
                  !likes.any((element) => element.uid == db.uid)
                      ? await db.addLikes(
                          Likes(uid: db.uid, imageId: df.imagesId), df.imagesId)
                      : await db.disLikes(df.imagesId);
                },
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(13.0)),
                    height: MediaQuery.of(context).size.height * 0.65,
                    child: Column(
                      children: [
                        1 == 1
                            ? Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(13.0),
                                  color: Colors.red,
                                  image: DecorationImage(
                                    image: CachedNetworkImageProvider(
                                      df.fisrt,
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                height:
                                    MediaQuery.of(context).size.height * 0.55,
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.transparent,
                                        Colors.black
                                      ],
                                      stops: [0.5, 3.0],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      tileMode: TileMode.repeated,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 12.0, right: 8.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          color: CupertinoColors
                                              .darkBackgroundGray,
                                          width: double.infinity,
                                        ),
                                        derr.isEnable
                                            ? Center(
                                                child: Icon(
                                                  CupertinoIcons.heart_fill,
                                                  size: 100,
                                                  color:
                                                      CupertinoColors.systemRed,
                                                ),
                                              )
                                            : SizedBox(height: 0),
                                        Text(dsf[0].name,
                                            style: TextStyle(
                                                fontSize: 37.0,
                                                color: Colors.white,
                                                fontFamily:
                                                    'SF-Pro-Text-Semibold')),
                                        SizedBox(
                                          height: 15.0,
                                        ),
                                        Row(
                                          children: [
                                            CircleAvatar(
                                              backgroundImage:
                                                  CachedNetworkImageProvider(
                                                "https://firebasestorage.googleapis.com/v0/b/fmc-media.appspot.com/o/Windows-10-user-icon-big.png?alt=media&token=a02afb6d-aa9b-44fb-a2a5-13aa4fb4bdca",
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'By ' + dsf[0].email,
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'SF-Pro-Text-Regular',
                                                        color: Color.fromRGBO(
                                                            235,
                                                            235,
                                                            235,
                                                            0.60)),
                                                  ),
                                                  SizedBox(height: 5.0),
                                                  Text(df.time,
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'SF-Pro-Text-Regular',
                                                          color: Color.fromRGBO(
                                                              235,
                                                              235,
                                                              235,
                                                              0.60))),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            : Stack(
                                children: [
                                  Container(
                                    // decoration: BoxDecoration(
                                    //   color: Colors.pink,
                                    //   image: DecorationImage(
                                    //     image: AssetImage('images/1.png'),
                                    //     fit: BoxFit.cover,
                                    //  ),
                                    //),
                                    height: MediaQuery.of(context).size.height,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Colors.transparent,
                                            Colors.black
                                          ],
                                          stops: [0.5, 3.0],
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          tileMode: TileMode.repeated,
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            color: CupertinoColors
                                                .darkBackgroundGray,
                                            width: double.infinity,
                                          ),
                                          Text('jsdfj',
                                              style: TextStyle(
                                                  fontSize: 35.0,
                                                  color: Colors.grey,
                                                  fontFamily: 'Lora-Regular')),
                                          SizedBox(
                                            height: 15.0,
                                          ),
                                          Row(
                                            children: [
                                              // CircleAvatar(
                                              //   backgroundImage:
                                              //       CachedNetworkImageProvider(
                                              //     "https://firebasestorage.googleapis.com/v0/b/fmc-media.appspot.com/o/Windows-10-user-icon-big.png?alt=media&token=a02afb6d-aa9b-44fb-a2a5-13aa4fb4bdca",
                                              //   ),
                                              // ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'By ',
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'Lora-Regular',
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                    SizedBox(height: 5.0),
                                                    Text("reg",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'Lora-Regular',
                                                            color:
                                                                Colors.grey)),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                color: CupertinoColors.black,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(13.0),
                                  bottomRight: Radius.circular(13.0),
                                )),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(children: [
                                      !likes.any((element) =>
                                              element.uid == db.uid)
                                          ? IconButton(
                                              icon: Icon(
                                                CupertinoIcons.heart,
                                                color: Color(0xfffffafa),
                                                size: 28,
                                              ),
                                              onPressed: () async {
                                                await db.addLikes(
                                                    Likes(
                                                        uid: db.uid,
                                                        imageId: df.imagesId),
                                                    df.imagesId);
                                              },
                                            )
                                          : IconButton(
                                              icon: Icon(
                                                CupertinoIcons.heart_fill,
                                                color: Color(0xfffd0054),
                                                size: 28,
                                              ),
                                              onPressed: () async {
                                                await db.disLikes(df.imagesId);
                                              },
                                            ),
                                      SizedBox(width: 5.0),
                                      Text(
                                        "Like  " + likes.length.toString(),
                                        style: TextStyle(
                                          fontFamily: 'Lora-Regular',
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ]),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    // Row(
                                    //   children: [
                                    //     IconButton(
                                    //       icon: Icon(CupertinoIcons.chat_bubble,
                                    //           color: Color(0xfffffafa), size: 28),
                                    //       onPressed: () => print('object'),
                                    //     ),
                                    //   ],
                                    // ),
                                  ],
                                ),
                                // !true
                                //     ? IconButton(
                                //         icon: Icon(
                                //           CupertinoIcons.bookmark,
                                //           color: Color(0xfffffafa),
                                //           size: 28,
                                //         ),
                                //         onPressed: () {})
                                //     : IconButton(
                                //         icon: Icon(
                                //           CupertinoIcons.bookmark_fill,
                                //           color: Color(0xfffd0054),
                                //           size: 28,
                                //         ),
                                //         onPressed: () => print(''),
                                //       )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
  }
}
