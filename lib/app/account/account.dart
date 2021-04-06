import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fmc/model/admin.dart';
import 'package:fmc/model/aiModel.dart';

import 'package:fmc/model/studentDetail.dart';
import 'package:fmc/model/studentUpload.dart';
import 'package:fmc/services/AI.dart';
import 'package:fmc/services/auth.dart';
import 'package:fmc/services/database.dart';
import 'package:fmc/widigits/errorDialog.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:path/path.dart' as Path;
import 'package:path_provider/path_provider.dart';

class Account extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final databse = Provider.of<Database>(context);
    return MultiProvider(
      providers: [
        StreamProvider<List<AdminControl>>.value(
          value: databse.adminXD(),
          initialData: null,
        ),
      ],
      child: AccountExtends(da: databse),
    );
  }
}

class AccountExtends extends StatefulWidget {
  final Database da;
  AccountExtends({Key key, this.da}) : super(key: key);

  @override
  _AccountExtendsState createState() => _AccountExtendsState();
}

class _AccountExtendsState extends State<AccountExtends> {
  List<Asset> images = <Asset>[];
  String _error = 'No Error Dectected';
  bool uploadStart = false;
  AiEngine aiengine = AiEngine();
  List uploadUrlX = [];
  final _refrence = FirebaseStorage.instance;
  double percent = 0;
  bool circle = false;

  @override
  void initState() {
    aiengine.loadModel();
    super.initState();
  }

  Future<File> getImageFileFromAssets(Asset asset) async {
    final byteData = await asset.getByteData();

    final tempFile =
        File("${(await getTemporaryDirectory()).path}/${asset.name}");
    final file = await tempFile.writeAsBytes(
      byteData.buffer
          .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes),
    );

    return file;
  }

  Future<void> deleteImage(String imageFileUrl) async {
    var fileUrl = Uri.decodeFull(Path.basename(imageFileUrl))
        .replaceAll(new RegExp(r'(\?alt).*'), '');
    final ref = _refrence.ref().child(fileUrl);
    await ref.delete();
  }

  Future saveImage(Asset asset) async {
    ByteData byteData = await asset.getByteData();
    List<int> imageData = byteData.buffer.asUint8List();
    Reference ref = _refrence.ref().child(DateTime.now().toString());
    UploadTask uploadTask = ref.putData(imageData);
    setState(() {
      circle = true;
    });
    uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
      percent = (snapshot.bytesTransferred / snapshot.totalBytes) * 100;
      percent.round().toString() == "100" ? uploadStart = false : print('');
      setState(() {});
    });
    uploadTask.whenComplete(() async {
      var uploadUrl = await ref.getDownloadURL();
      setState(() {
        circle = false;
        uploadUrlX.add(uploadUrl);
      });
    }).catchError((onError) {
      uploadStart = false;
    });
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = <Asset>[];
    String error = 'No Error Detected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 3,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#232323",
          actionBarTitle: "Select Photos",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      images = resultList;
      _error = error;
    });
  }

  @override
  Widget build(BuildContext context) {
    final details = Provider.of<StudentDetails>(context);
    final data = Provider.of<List<AdminControl>>(context);
    final asassX = Provider.of<Auth>(context);
    final String idF = DateTime.now().toString();

    return Scaffold(
      backgroundColor: CupertinoColors.black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromRGBO(29, 29, 29, 1),
        title: Text(
          'Account',
          style: TextStyle(
            fontFamily: 'SF-Pro-Display-Bold',
            fontSize: 34,
            color: Color.fromRGBO(255, 255, 255, 1),
          ),
        ),
        actions: [
          CupertinoButton(
              child: Text(
                'Logout',
                style: TextStyle(
                    color: CupertinoColors.systemRed, fontFamily: 'SF-Pro'),
              ),
              onPressed: () {
                logoutdialogX(context, asassX);
              })
        ],
      ),
      body: data == null
          ? Center(child: CupertinoActivityIndicator())
          : SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(width: double.infinity),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  details.name,
                                  style: TextStyle(
                                    color: Color.fromRGBO(255, 255, 255, 1),
                                    fontFamily: 'SF-Pro-Display-Bold',
                                    fontSize: 27.0,
                                  ),
                                ),
                                Text(
                                  details.email,
                                  style: TextStyle(
                                    color: Color.fromRGBO(255, 255, 255, 1),
                                    fontFamily: 'SF-Pro-Display-Bold',
                                    fontSize: 17.0,
                                  ),
                                ),
                                SizedBox(height: 50),
                                !circle
                                    ? Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.3,
                                        child: GridView.count(
                                          crossAxisCount: 3,
                                          children: List.generate(images.length,
                                              (index) {
                                            Asset asset = images[index];
                                            return AssetThumb(
                                              asset: asset,
                                              width: 400,
                                              height: 400,
                                            );
                                          }),
                                        ),
                                      )
                                    : Center(
                                        child: CircularPercentIndicator(
                                          radius: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.25,
                                          lineWidth: 2.0,
                                          percent: percent / 100,
                                          animation: true,
                                          animationDuration: 1200,
                                          center: percent.round().toString() ==
                                                  "100"
                                              ? Icon(
                                                  CupertinoIcons.check_mark,
                                                  color: CupertinoColors
                                                      .activeBlue,
                                                  size: 65,
                                                )
                                              : Text(
                                                  percent.round().toString() +
                                                      "%",
                                                  style: TextStyle(
                                                    fontSize: 32,
                                                    color: Color.fromRGBO(
                                                        255, 255, 255, 1),
                                                    fontFamily:
                                                        'SF-Pro-Display-Bold',
                                                  ),
                                                ),
                                          progressColor:
                                              CupertinoColors.activeGreen,
                                        ),
                                      ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        !circle
                            ? CupertinoButton(
                                color: data[0].isAnyComp
                                    ? CupertinoColors.systemRed
                                    : CupertinoColors.inactiveGray,
                                child: Text(
                                  '           Add           ',
                                  style: TextStyle(
                                      fontFamily: 'SF-Pro-Display-Bold'),
                                ),
                                onPressed: loadAssets)
                            : Text(''),
                        !uploadStart
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: uploadUrlX.isEmpty
                                      ? !circle
                                          ? CupertinoButton(
                                              color: data[0].isAnyComp
                                                  ? CupertinoColors.systemRed
                                                  : CupertinoColors
                                                      .inactiveGray,
                                              child: Text('       Upload      ',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'SF-Pro-Display-Bold')),
                                              onPressed: () async {
                                                try {
                                                  for (int i = 0;
                                                      i < images.length;
                                                      i++) {
                                                    final file =
                                                        await getImageFileFromAssets(
                                                            images[i]);
                                                    final res = await aiengine
                                                        .runModel(file);
                                                    res.forEach(
                                                        (element) async {
                                                      if (element['label'] !=
                                                              "sexy" ||
                                                          element['label'] !=
                                                              "porn") {
                                                        await saveImage(
                                                            images[i]);
                                                      } else {
                                                        await widget.da
                                                            .addNOTDATAImages(
                                                                StudentUpload(
                                                                  imagesId: '',
                                                                  uid: widget
                                                                      .da.uid,
                                                                  time: DateTime
                                                                          .now()
                                                                      .toString(),
                                                                  uploadUrl: '',
                                                                ),
                                                                idF);

                                                        dialog(context,
                                                            "This is not Correct according to guidelines");
                                                      }
                                                    });
                                                  }
                                                } catch (e) {
                                                  dialog(context, e.message);
                                                }
                                                images.clear();
                                              },
                                            )
                                          : Center(
                                              child: Text(
                                                  "Please Wait and Relax",
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          255, 255, 255, 1),
                                                      fontFamily:
                                                          'SF-Pro-Display-Bold')),
                                            )
                                      : Padding(
                                          padding: const EdgeInsets.all(18.0),
                                          child: Column(
                                            children: [
                                              Text(
                                                'Yes I Confirm to Upload these images\n',
                                                style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      255, 255, 255, 1),
                                                  fontFamily:
                                                      'SF-Pro-Display-Bold',
                                                  fontSize: 17.0,
                                                ),
                                              ),
                                              CupertinoButton(
                                                color:
                                                    CupertinoColors.systemRed,
                                                child:
                                                    Text('      Confirm     '),
                                                onPressed: () async {
                                                  await widget.da.addImages(
                                                      StudentUpload(
                                                        imagesId: idF,
                                                        uid: widget.da.uid,
                                                        time: DateTime.now()
                                                            .toString(),
                                                        uploadUrl: '',
                                                      ),
                                                      idF);
                                                  for (int i = 0;
                                                      i < uploadUrlX.length;
                                                      i++) {
                                                    await widget.da.addImagesXX(
                                                        idF,
                                                        uploadUrlX[i],
                                                        i.toString());
                                                  }
                                                  uploadUrlX.clear();
                                                },
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(18.0),
                                                child: CupertinoButton(
                                                  color: CupertinoColors
                                                      .inactiveGray,
                                                  child: Text(
                                                      '       Deny       '),
                                                  onPressed: () async {
                                                    for (int i = 0;
                                                        i < uploadUrlX.length;
                                                        i++) {
                                                      deleteImage(
                                                          uploadUrlX[i]);
                                                    }
                                                    uploadUrlX.clear();
                                                    setState(() {});
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                ),
                              )
                            : Center(child: CupertinoActivityIndicator()),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}

class ButtonSelect extends StatelessWidget {
  final Function callback;
  const ButtonSelect({Key key, this.callback}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.07,
        width: MediaQuery.of(context).size.height * 0.07,
        decoration: BoxDecoration(
          color: Color.fromRGBO(255, 69, 48, 1),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Icon(
          CupertinoIcons.add,
          color: Color.fromRGBO(255, 255, 255, 1),
        ),
      ),
    );
  }
}
