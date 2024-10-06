import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'dart:typed_data';
import 'package:permission_handler/permission_handler.dart';

class DetailLicence extends StatefulWidget {
  final String catsImagePath;
  final String catName;
  final String fname;
  final String lname;
  final String address;
  final String phoneNumber;
  final String pdfUrl;

  DetailLicence(
      {super.key,
      required this.catsImagePath,
      required this.catName,
      required this.fname,
      required this.lname,
      required this.address,
      required this.phoneNumber,
      required this.pdfUrl});

  @override
  State<DetailLicence> createState() => _DetailLicenceState();
}

class _DetailLicenceState extends State<DetailLicence> {
  final ScreenshotController screenshotController = ScreenshotController();

  Future<void> captureAndSaveImage() async {
    final Uint8List? uint8list = await screenshotController.capture();
    print(uint8list);
    if (uint8list != null) {
      print("uint OK!!");

      final PermissionStatus status = await Permission.photos.request();
      
      // if (Platform.isAndroid && await Permission.photos.isDenied) {
      //   final PermissionStatus status1;
      //   status1 = await Permission.photos.request();
      //   print("Status 1: ${status1}");
      // }
      // if (Platform.isAndroid && await Permission.videos.isDenied) {
      //   final PermissionStatus status2;
      //   status2 = await Permission.videos.request();
      //   print("Status 2: ${status2}");
      // }

      
      // final PermissionStatus status;
      // if (Platform.isAndroid && await Permission.storage.isDenied) {
      //   status = await Permission.storage.request();
      // } else {
      //   status = await Permission.photos.status;
      // }
      print("${status}");
      if (status.isGranted) {
        final String imageName =
            'Qr_Code_${DateTime.now().microsecondsSinceEpoch}.png';
        final Directory directory = await getApplicationCacheDirectory();
        final String path = '${directory.path}/$imageName';

        File imageFile = File(path);
        await imageFile.writeAsBytes(uint8list);

        await ImageGallerySaver.saveFile(path);
        print("Image Saved to Gallery!!");
        ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('ดาวน์โหลดรูป QR code เสร็จแล้ว!'),
          duration: Duration(seconds: 3),
        ),
      );
      } else {
        print("Permission to access storage denied");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 60,
        centerTitle: true,
        title: Text("รายละเอียดข้อมูล"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(widget.catsImagePath),
                radius: 150,
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "ชื่อแมว: ${widget.catName}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "ชื่อเจ้าของ: ${widget.fname} ${widget.lname}",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "ที่อยู่: ${widget.address}",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "เบอร์โทร: ${widget.phoneNumber}",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('รายละเอียดของแมว',style: TextStyle(fontWeight: FontWeight.w100, fontSize: 14),),
                      Screenshot(
                        controller: screenshotController,
                        child: QrImageView(
                          data: widget.pdfUrl,
                          version: QrVersions.auto,
                          gapless: true,
                          size: 180,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            await captureAndSaveImage();
                          },
                          child: Text("Download Qrcode"))
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
