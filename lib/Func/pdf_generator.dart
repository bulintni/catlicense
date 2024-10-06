import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:catlicense/model/catdata.dart';
import 'package:http/http.dart' as http; // เพิ่มแพ็กเกจ http

class PdfGenerator {
  Future<File> generatorAndSavePdf(OwnerData ownerData, String imageUrl) async {
    final pdf = pw.Document();
    var ttf;

    try {
      final fontData = await rootBundle.load("assets/Font/Kanit-Regular.ttf");
      ttf = pw.Font.ttf(fontData);
    } catch (e) {
      print(e);
    } finally {
      // โหลดภาพจาก URL
      final response = await http
          .get(Uri.parse(imageUrl)); // ใช้ imageUrl จาก ownerData
      final imageBytes = response.bodyBytes; // ข้อมูลภาพในรูปแบบไบต์
      final pw.MemoryImage image = pw.MemoryImage(imageBytes);

      pdf.addPage(
        pw.Page(
          build: (pw.Context context) => pw.Center(
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Image(image, width: 300, height: 300),
                pw.Text("ข้อมูลเจ้าของ",
                    style: pw.TextStyle(fontSize: 24, font: ttf)),
                pw.SizedBox(height: 10),
                pw.Text("ชื่อ: ${ownerData.firstName}",
                    style: pw.TextStyle(font: ttf)),
                pw.Text("นามสกุล: ${ownerData.lastName}",
                    style: pw.TextStyle(font: ttf)),
                pw.Text("ชื่อแมว: ${ownerData.catName}",
                    style: pw.TextStyle(font: ttf)),
                pw.Text("ที่อยู่: ${ownerData.address}",
                    style: pw.TextStyle(font: ttf)),
                pw.Text("เบอร์โทรเจ้าของ: ${ownerData.phoneNumber}",
                    style: pw.TextStyle(font: ttf)),
              ],
            ),
          ),
        ),
      );

      final output = await getTemporaryDirectory();
      final file = File("${output.path}/cat_owner_info.pdf");
      await file.writeAsBytes(await pdf.save());

      return file;
    }
  }
}
