import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fmc/model/admin.dart';
import 'package:fmc/model/studentDetail.dart';
import 'package:fmc/model/studentUpload.dart';
import 'package:fmc/services/camera.dart';
import 'package:fmc/services/database.dart';
import 'package:fmc/services/firebaseStorage.dart';
import 'package:fmc/widigits/errorDialog.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class Account extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final databse = Provider.of<Database>(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<StorageX>(create: (context) => StorageX()),
        ChangeNotifierProvider<PickImage>(create: (context) => PickImage()),
        StreamProvider<List<AdminControl>>.value(
          value: databse.adminXD(),
          initialData: null,
        ),
      ],
      child: AccountExtends(da: databse),
    );
  }
}

class AccountExtends extends StatelessWidget {
  final Database da;

  const AccountExtends({Key key, this.da}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final details = Provider.of<StudentDetails>(context);
    final data = Provider.of<List<AdminControl>>(context);
    final pickImage = Provider.of<PickImage>(context);
    final sX = Provider.of<StorageX>(context);
    final String idF = Uuid().v4().toString();
    if (data == null) {
      return Center(child: CircularProgressIndicator());
    } else {
      return Scaffold(
        body: SafeArea(
          child: Container(
            child: Column(
              children: [
                Container(width: double.infinity),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(details.name),
                        Text(details.email),
                      ],
                    ),
                  ),
                ),
                sX.percent == 0
                    ? Expanded(
                        flex: 1,
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.4,
                          child: GridView.count(
                            crossAxisCount: 3,
                            children: List.generate(
                                pickImage.images.length == null
                                    ? 0
                                    : pickImage.images.length, (index) {
                              Asset asset = pickImage.images[index];
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: AssetThumb(
                                  asset: asset,
                                  width: 300,
                                  height: 300,
                                ),
                              );
                            }),
                          ),
                        ))
                    : CircularPercentIndicator(
                        radius: MediaQuery.of(context).size.height * 0.25,
                        lineWidth: 2.0,
                        percent: sX.percent / 100,
                        animation: true,
                        animationDuration: 1200,
                        center: sX.percent.round().toString() == "100"
                            ? Icon(
                                CupertinoIcons.check_mark,
                                color: CupertinoColors.activeBlue,
                                size: 65,
                              )
                            : Text(
                                sX.percent.round().toString() + "%",
                                style: TextStyle(fontSize: 32),
                              ),
                        progressColor: CupertinoColors.activeGreen,
                      ),

                SizedBox(height: 10),
                //
                Center(
                  child: CupertinoButton(
                      color: CupertinoColors.systemRed,
                      child: Text('Select Image'),
                      onPressed: () {
                        try {
                          pickImage.loadAssets();
                        } catch (e) {
                          dialog(context, e.message);
                          pickImage.errorx = e.message;
                        }
                      }),
                ),
                SizedBox(height: 10),
                !sX.uploadStart
                    ? Center(
                        child: sX.uploadUrlX.isEmpty
                            ? CupertinoButton(
                                color: data[0].isAnyComp
                                    ? CupertinoColors.systemRed
                                    : CupertinoColors.inactiveGray,
                                child: Text('      Upload     '),
                                onPressed: () async {
                                  pickImage.images.isNotEmpty
                                      ? sX.uploadTaskBegin()
                                      : print('');
                                  try {
                                    if (pickImage.images.isNotEmpty
                                        //&& data[0].isAnyComp

                                        ) {
                                      for (int i = 0;
                                          i < pickImage.images.length;
                                          i++) {
                                        await sX.saveImage(pickImage.images[i]);
                                      }
                                    } else {
                                      throw Exception(
                                          "Select a image Or No competition is there");
                                    }
                                  } catch (e) {
                                    dialog(context, e.message);
                                  }

                                  pickImage.images.clear();
                                },
                              )
                            : Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Column(
                                  children: [
                                    Text(
                                        'Yes I Confirm to Upload these images'),
                                    CupertinoButton(
                                      color: CupertinoColors.systemRed,
                                      child: Text('      Confirm     '),
                                      onPressed: () async {
                                        await da.addImages(
                                            StudentUpload(
                                              imagesId: idF,
                                              uid: da.uid,
                                              time: DateTime.now().toString(),
                                              uploadUrl: '',
                                            ),
                                            idF);
                                        for (int i = 0;
                                            i < sX.uploadUrlX.length;
                                            i++) {
                                          await da.addImagesXX(idF,
                                              sX.uploadUrlX[i], i.toString());
                                        }
                                        sX.uploadUrlX.clear();
                                      },
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(18.0),
                                      child: CupertinoButton(
                                        color: CupertinoColors.inactiveGray,
                                        child: Text('       Deny       '),
                                        onPressed: () async {
                                          sX.uploadUrlX.clear();
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                      )
                    : Center(child: CircularProgressIndicator()),
              ],
            ),
          ),
        ),
      );
    }
  }
}
