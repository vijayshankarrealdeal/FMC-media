import 'package:flutter/material.dart';
import 'package:fmc/app/leaderBoard/leaderBoard.dart';
import 'package:fmc/app/account/account.dart';

import 'package:fmc/app/navigation/bottomNav.dart';
import 'package:fmc/app/navigation/navigationlogic.dart';
import 'package:fmc/app/noticeBoard/NoticeBoard.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  final List<Widget> children = [
    LeaderBoard(),
    NoticeBoard(),
    Account(),
  ];

  @override
  Widget build(BuildContext context) {
    final nav = Provider.of<ChangeofPage>(context);
    return Scaffold(
      body: children[nav.pageIndex],
      bottomNavigationBar: MaterialBottomNavigationBar(),
    );
  }
}
