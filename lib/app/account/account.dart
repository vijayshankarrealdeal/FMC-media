import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fmc/model/admin.dart';
import 'package:fmc/model/studentDetail.dart';
import 'package:fmc/services/database.dart';
import 'package:provider/provider.dart';

class Account extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final databse = Provider.of<Database>(context);
    return StreamProvider<List<AdminControl>>.value(
      value: databse.adminXD(),
      initialData: null,
      child: AccountExtends(),
    );
  }
}

class AccountExtends extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final details = Provider.of<StudentDetails>(context);
    final data = Provider.of<List<AdminControl>>(context);
    return data == null
        ? Center(child: CircularProgressIndicator())
        : Container(
            child: ListView(
              children: [
                Container(width: double.infinity),
                Center(
                  child: CupertinoButton(
                      color: data[0].isAnyComp
                          ? CupertinoColors.systemRed
                          : CupertinoColors.inactiveGray,
                      child: Text('Upload'),
                      onPressed: () {}),
                )
              ],
            ),
          );
  }
}
