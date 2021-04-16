import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fmc/model/leaderBoardModel.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:cached_network_image/cached_network_image.dart';

class LeaderBoardExtensionWith3Images extends StatelessWidget {
  final LeaderBoardModel data;

  LeaderBoardExtensionWith3Images({Key key, this.data}) : super(key: key);
  List<String> m = [];
  @override
  Widget build(BuildContext context) {
    m.add(data.fisrt);
    data.second.isNotEmpty ? m.add(data.second) : print("NotHere");
    data.third.isNotEmpty ? m.add(data.third) : print("NotHere");
    return SafeArea(
      child: Scaffold(
          backgroundColor: CupertinoColors.black,
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: Carousel(
              images: m.map((e) => CachedNetworkImage(imageUrl: e)).toList(),
              autoplay: false,
            ),
          )),
    );
  }
}
