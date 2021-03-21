import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fmc/model/imageModel.dart';
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
    final df = Provider.of<List<LeaderBoardModel>>(context);
    return df == null
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Color.fromRGBO(255, 255, 255, 1),
              title: Text(
                'Home',
                style: TextStyle(
                  fontFamily: 'SF-Pro-Display-Bold',
                  fontSize: 34,
                  color: Color.fromRGBO(0, 0, 0, 1),
                ),
              ),
            ),
            body: Container(
                margin: EdgeInsets.only(top: 18.0),
                child: ListView.builder(
                    itemCount: 200,
                    itemBuilder: (context, i) {
                      return GestureDetector(
                        //onDoubleTap: () => print(isLiked),
                        onTap: () => print(''),
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
                                          borderRadius:
                                              BorderRadius.circular(13.0),
                                          color: Colors.red,
                                          // image: DecorationImage(
                                          //   image: CachedNetworkImageProvider(
                                          //     l[i].poster,
                                          //   ),
                                          //   fit: BoxFit.cover,
                                          // ),
                                        ),
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.55,
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
                                                Text("Helllo",
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
                                                        // backgroundImage:
                                                        //     CachedNetworkImageProvider(
                                                        //         l[i].user[
                                                        //             'mediaUrl']),
                                                        ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            'By ',
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'SF-Pro-Text-Regular',
                                                                color: Color
                                                                    .fromRGBO(
                                                                        235,
                                                                        235,
                                                                        235,
                                                                        0.60)),
                                                          ),
                                                          SizedBox(height: 5.0),
                                                          Text('f22/10',
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'SF-Pro-Text-Regular',
                                                                  color: Color
                                                                      .fromRGBO(
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
                                            decoration: BoxDecoration(
                                              color: Colors.pink,
                                              // image: DecorationImage(
                                              //   image:
                                              //       CachedNetworkImageProvider(
                                              //     l[i].poster,
                                              //   ),
                                              //   fit: BoxFit.cover,
                                              // ),
                                            ),
                                            height: MediaQuery.of(context)
                                                .size
                                                .height,
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
                                                          fontFamily:
                                                              'Lora-Regular')),
                                                  SizedBox(
                                                    height: 15.0,
                                                  ),
                                                  Row(
                                                    children: [
                                                      CircleAvatar(
                                                          // backgroundImage:
                                                          // CachedNetworkImageProvider(
                                                          //     l[i].user[
                                                          //         'mediaUrl']),
                                                          ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              'By ',
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'Lora-Regular',
                                                                color:
                                                                    Colors.grey,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                height: 5.0),
                                                            Text("reg",
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'Lora-Regular',
                                                                    color: Colors
                                                                        .grey)),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Row(children: [
                                              !false
                                                  ? IconButton(
                                                      icon: Icon(
                                                        CupertinoIcons.heart,
                                                        color:
                                                            Color(0xfffffafa),
                                                        size: 28,
                                                      ),
                                                      onPressed: () =>
                                                          print(''),
                                                    )
                                                  : IconButton(
                                                      icon: Icon(
                                                        CupertinoIcons
                                                            .heart_fill,
                                                        color:
                                                            Color(0xfffd0054),
                                                        size: 28,
                                                      ),
                                                      onPressed: () =>
                                                          print('object'),
                                                    ),
                                              SizedBox(width: 5.0),
                                              Text(
                                                " Like",
                                                style: TextStyle(
                                                  fontFamily: 'Lora-Regular',
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ]),
                                            SizedBox(
                                              width: 10.0,
                                            ),
                                            Row(
                                              children: [
                                                IconButton(
                                                  icon: Icon(
                                                      CupertinoIcons
                                                          .chat_bubble,
                                                      color: Color(0xfffffafa),
                                                      size: 28),
                                                  onPressed: () =>
                                                      print('object'),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        !true
                                            ? IconButton(
                                                icon: Icon(
                                                  CupertinoIcons.bookmark,
                                                  color: Color(0xfffffafa),
                                                  size: 28,
                                                ),
                                                onPressed: () {})
                                            : IconButton(
                                                icon: Icon(
                                                  CupertinoIcons.bookmark_fill,
                                                  color: Color(0xfffd0054),
                                                  size: 28,
                                                ),
                                                onPressed: () => print(''),
                                              )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    })),
          );
  }
}
