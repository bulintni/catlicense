import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerHelper {
  Future<File?> pickImage() async{
    //เข้าถึง ImpagePicker
    final ImagePicker picker = ImagePicker();
    //สถานที่ที่เข้าถึงคือ gallery
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if(image != null){
      return File(image.path); //คืนค่ารูปภาพออกมา
    }
    return null;
  }

  //ฟังก์ชั่นสำหรับบันทึกรูปภาพลงในโฟล์เดอร์ชั่วคราวของอุปกรณ์
  Future<File> saveImage(File imageFile) async {
    final directory = await getApplicationCacheDirectory();
    final String path = directory.path;
    const String fileName = 'save_image.png';
    final File savedFile = await imageFile.copy('$path/$fileName');

    return savedFile;
  }
}