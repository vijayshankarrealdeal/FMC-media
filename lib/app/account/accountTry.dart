// import 'dart:io';
// import 'dart:typed_data';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:fmc/model/admin.dart';
// import 'package:fmc/model/studentDetail.dart';
// import 'package:fmc/model/studentUpload.dart';
// import 'package:fmc/services/auth.dart';
// import 'package:fmc/services/database.dart';
// import 'package:fmc/widigits/errorDialog.dart';
// import 'package:provider/provider.dart';
// import 'dart:async';
// import 'package:image_picker/image_picker.dart';
// import 'package:percent_indicator/circular_percent_indicator.dart';
// import 'package:path/path.dart' as Path;
//
// class Account extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final databse = Provider.of<Database>(context);
//     return MultiProvider(
//       providers: [
//         StreamProvider<List<AdminControl>>.value(
//           value: databse.adminXD(),
//           initialData: null,
//         ),
//       ],
//       child: AccountExtends(da: databse),
//     );
//   }
// }
//
// class AccountExtends extends StatefulWidget {
//   final Database da;
//   AccountExtends({Key key, this.da}) : super(key: key);
//
//   @override
//   _AccountExtendsState createState() => _AccountExtendsState();
// }
//
// class _AccountExtendsState extends State<AccountExtends> {
//   final _refrence = FirebaseStorage.instance;
//   double percent = 0;
//   bool circle = false;
//   File _image;
//   final picker = ImagePicker();
//
//   Future getImage() async {
//     final pickedFile = await picker.getImage(source: ImageSource.gallery);
//
//     setState(() {
//       if (pickedFile != null) {
//         _image = File(pickedFile.path);
//       } else {
//         print('No image selected.');
//       }
//     });
//   }
//
//
//   Future<void> deleteImage(String imageFileUrl) async {
//     var fileUrl = Uri.decodeFull(Path.basename(imageFileUrl))
//         .replaceAll(new RegExp(r'(\?alt).*'), '');
//     final ref = _refrence.ref().child(fileUrl);
//     await ref.delete();
//   }
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     final details = Provider.of<StudentDetails>(context);
//     final data = Provider.of<List<AdminControl>>(context);
//     final asassX = Provider.of<Auth>(context);
//     final String idF = DateTime.now().toString();
//
//     return Scaffold(
//       backgroundColor: CupertinoColors.black,
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Color.fromRGBO(29, 29, 29, 1),
//         title: Text(
//           'Account',
//           style: TextStyle(
//             fontFamily: 'SF-Pro-Display-Bold',
//             fontSize: 34,
//             color: Color.fromRGBO(255, 255, 255, 1),
//           ),
//         ),
//         actions: [
//           CupertinoButton(
//               child: Text(
//                 'Logout',
//                 style: TextStyle(
//                     color: CupertinoColors.systemRed, fontFamily: 'SF-Pro'),
//               ),
//               onPressed: () {
//                 logoutdialogX(context, asassX);
//               })
//         ],
//       ),
//       body: data == null
//           ? Center(child: CupertinoActivityIndicator())
//           : SafeArea(
//               child: SingleChildScrollView(
//                 child: Container(
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         children: [
//                           Container(width: double.infinity),
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Align(
//                               alignment: Alignment.centerLeft,
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     details.name,
//                                     style: TextStyle(
//                                       color: Color.fromRGBO(255, 255, 255, 1),
//                                       fontFamily: 'SF-Pro-Display-Bold',
//                                       fontSize: 27.0,
//                                     ),
//                                   ),
//                                   Text(
//                                     details.email,
//                                     style: TextStyle(
//                                       color: Color.fromRGBO(255, 255, 255, 1),
//                                       fontFamily: 'SF-Pro-Display-Bold',
//                                       fontSize: 17.0,
//                                     ),
//                                   ),
//                                   SizedBox(height: 30),
//                                   _image == null
//                                       ? Text('No image selected.')
//                                       : Image.file(_image),
//                                   Center(
//                                     child: CupertinoButton(
//                                       color:CupertinoColors.systemRed,
//                                         child: Text("Add"), onPressed:()=> getImage()),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           )
//                         ]),
//                   ),
//                 ),
//               ),
//             ),
//     );
//   }
// }
//
// // Future saveImage() async {
// // ByteData byteData = await asset.getByteData();
// // List<int> imageData = byteData.buffer.asUint8List();
// // Reference ref = _refrence.ref().child(DateTime.now().toString());
// // UploadTask uploadTask = ref.putData(imageData);
// // setState(() {
// //   circle = true;
// // });
// // uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
// //   percent = (snapshot.bytesTransferred / snapshot.totalBytes) * 100;
// //   percent.round().toString() == "100" ? uploadStart = false : print('');
// //   setState(() {});
// // });
// // uploadTask.whenComplete(() async {
// //   var uploadUrl = await ref.getDownloadURL();
// //   setState(() {
// //     circle = false;
// //     uploadUrlX.add(uploadUrl);
// //   });
// // }).catchError((onError) {
// //   uploadStart = false;
// // });
// // }