import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fmc/model/admin.dart';
import 'package:fmc/model/studentDetail.dart';
import 'package:fmc/services/camera.dart';
import 'package:fmc/services/database.dart';
import 'package:fmc/services/firebaseStorage.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:provider/provider.dart';

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
      child: AccountExtends(),
    );
  }
}

class AccountExtends extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final details = Provider.of<StudentDetails>(context);
    final data = Provider.of<List<AdminControl>>(context);
    final pickImage = Provider.of<PickImage>(context);
    final sX = Provider.of<StorageX>(context);

    if (data == null) {
      return Center(child: CircularProgressIndicator());
    } else {
      return Container(
        child: ListView(
          children: [
            Container(width: double.infinity),
            Text(details.email),
            Expanded(
                child: Container(
              height: 400,
              child: GridView.count(
                crossAxisCount: 3,
                children: List.generate(pickImage.images.length, (index) {
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
            )),
            Center(
              child: CupertinoButton(
                  color: CupertinoColors.systemRed,
                  child: Text('Select Image'),
                  onPressed: () {
                    try {
                      pickImage.loadAssets();
                    } catch (e) {
                      pickImage.errorx = e.message;
                    }
                  }),
            ),
            SizedBox(height: 10),
            Center(
              child: CupertinoButton(
                  color: data[0].isAnyComp
                      ? CupertinoColors.systemRed
                      : CupertinoColors.inactiveGray,
                  child: Text('Upload'),
                  onPressed: () {
                    pickImage.images.forEach((element) async {
                      final tLink = await sX.saveImage(element);
                      print(tLink);
                    });
                  }),
            )
          ],
        ),
      );
    }
  }
}
