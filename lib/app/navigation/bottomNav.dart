import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fmc/app/navigation/navigationlogic.dart';
import 'package:provider/provider.dart';

class MaterialBottomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final nav = Provider.of<ChangeofPage>(context);
    return Container(
      height: 51.0,
      decoration: BoxDecoration(
        color: nav.navbackground,
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 4.0, right: 4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
                icon: Icon(
                  CupertinoIcons.app_badge,
                  size: nav.active[0] ? nav.size : nav.activesize,
                  color: nav.active[0] ? nav.color : nav.activeColor,
                ),
                onPressed: () {
                  nav.kCallback(0);
                  nav.change(0);
                }),
            IconButton(
                icon: Icon(
                  CupertinoIcons.heart,
                  size: nav.active[1] ? nav.size : nav.activesize,
                  color: nav.active[1] ? nav.color : nav.activeColor,
                ),
                onPressed: () {
                  nav.kCallback(1);
                  nav.change(1);
                }),
            IconButton(
                icon: Icon(
                  CupertinoIcons.profile_circled,
                  size: nav.active[2] ? nav.size : nav.activesize,
                  color: nav.active[2] ? nav.color : nav.activeColor,
                ),
                onPressed: () {
                  nav.kCallback(2);
                  nav.change(2);
                }),
          ],
        ),
      ),
    );
  }
}
