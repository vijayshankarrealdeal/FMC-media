import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fmc/app/leaderBoard/LeaderBoardDetails.dart';
import 'package:fmc/app/leaderBoard/state.dart';
import 'package:fmc/model/leaderBoardModel.dart';
import 'package:fmc/services/database.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class LeaderBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final db = Provider.of<Database>(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<StateHearShowS>(
            create: (context) => StateHearShowS()),
      ],
      child: LeaderBoardExtends(),
    );
  }
}

class LeaderBoardExtends extends StatefulWidget {
  @override
  _LeaderBoardExtendsState createState() => _LeaderBoardExtendsState();
}

class _LeaderBoardExtendsState extends State<LeaderBoardExtends>
    with TickerProviderStateMixin  {
  Animation  _heartAnimation;
  AnimationController  _heartAnimationController;
  @override
  void initState() {
    _heartAnimationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 800));
    _heartAnimation = Tween(begin: 120.0, end: 170.0).animate(CurvedAnimation(
        curve: Curves.bounceOut, parent: _heartAnimationController));
    // TODO: implement initState
    super.initState();
  }
    bool isEnable = false;
  @override
  Widget build(BuildContext context) {
    final db = Provider.of<Database>(context);
    final derr = Provider.of<StateHearShowS>(context);
    // final df = Provider.of<List<LeaderBoardModel>>(context);
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
      //
      body: StreamBuilder<List<LeaderBoardModel>>(
        stream: db.leader(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              margin: EdgeInsets.only(top: 18.0),
              child: ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, i) {
                  bool liked = false;
                  int lik = 0;
                  snapshot.data[i].likes.forEach((key, value) {
                    if (value) {
                      lik++;
                    }
                    if (key == db.uid && value == true) {
                      liked = true;
                    }
                  });

                  return GestureDetector(
                    onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>LeaderBoardExtensionWith3Images(
                      data:snapshot.data[i]
                    ))),
                    onDoubleTap: () async {
                      setState(() {
                        isEnable = true;
                        _heartAnimationController.forward();
                      });

                      !liked
                          ? await db.addLikes(snapshot.data[i].imagesId)
                          : await db.disLikes(snapshot.data[i].imagesId);
                      setState(() {
                        isEnable = false;
                        _heartAnimationController.reverse();
                      });
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
                                      color: CupertinoColors.black,
                                      image: DecorationImage(
                                        image: CachedNetworkImageProvider(
                                          snapshot.data[i].fisrt,
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    height: MediaQuery.of(context).size.height *
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
                                            // Container(
                                            //   color: CupertinoColors
                                            //       .darkBackgroundGray,
                                            //   width: double.infinity,
                                            // ),
                                            isEnable
                                                ? AnimatedBuilder(
                                              animation: _heartAnimationController,
                                                    builder: (context, child) {
                                                      return Center(
                                                        child: Icon(
                                                          CupertinoIcons
                                                              .heart_fill,
                                                          size: _heartAnimation.value,
                                                          color: Color.fromRGBO(
                                                              255, 69, 58, 1),
                                                        ),
                                                      );
                                                    },
                                                  )
                                                : SizedBox(height: 0),
                                            Text(snapshot.data[i].name,
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
                                                  backgroundImage: AssetImage(
                                                      'images/1.png'),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'By ' +
                                                            snapshot
                                                                .data[i].email,
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'SF-Pro-Text-Regular',
                                                            color:
                                                                Color.fromRGBO(
                                                                    235,
                                                                    235,
                                                                    235,
                                                                    0.60)),
                                                      ),
                                                      SizedBox(height: 5.0),
                                                      Text(
                                                          snapshot.data[i].time,
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
                                        height:
                                            MediaQuery.of(context).size.height,
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
                                                                'Lora-Regular',
                                                            color: Colors.grey,
                                                          ),
                                                        ),
                                                        SizedBox(height: 5.0),
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
                                          !liked
                                              ? IconButton(
                                                  icon: Icon(
                                                    CupertinoIcons.heart,
                                                    color: Color(0xfffffafa),
                                                    size: 28,
                                                  ),
                                                  onPressed: () async {
                                                    await db.addLikes(snapshot
                                                        .data[i].imagesId);
                                                  },
                                                )
                                              : IconButton(
                                                  icon: Icon(
                                                    CupertinoIcons.heart_fill,
                                                    color: Color(0xfffd0054),
                                                    size: 28,
                                                  ),
                                                  onPressed: () async {
                                                    await db.disLikes(snapshot
                                                        .data[i].imagesId);
                                                  },
                                                ),
                                          SizedBox(width: 5.0),
                                          Text(
                                            "Like  " + lik.toString(),
                                            style: TextStyle(
                                              fontFamily: 'Lora-Regular',
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ]),
                                        SizedBox(
                                          width: 10.0,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          } else {
            return CupertinoActivityIndicator();
          }
        },
      ),
    );
  }
}
