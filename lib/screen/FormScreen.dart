import 'package:catlicense/Func/image_picker_helper.dart';
import 'package:catlicense/model/catdata.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class Formscreen extends StatefulWidget {
  const Formscreen({super.key});

  @override
  State<Formscreen> createState() => _FormscreenState();
}

class _FormscreenState extends State<Formscreen> {
  final formKey = GlobalKey<FormState>();
  final ImagePickerHelper _imagePickerHelper = ImagePickerHelper();
  final OwnerData ownerData = OwnerData();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("แบบฟอร์มเจ้าของแมว"),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "ชื่อเจ้าของ",
                    style: TextStyle(fontSize: 14),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.zero)),
                    onSaved: (String? fname) {
                      ownerData.firstName = fname;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "นามสกุลเจ้าของ",
                    style: TextStyle(fontSize: 14),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.zero)),
                    onSaved: (String? lname) {
                      ownerData.lastName = lname;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "ชื่อแมว",
                    style: TextStyle(fontSize: 14),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.zero)),
                    onSaved: (String? catName) {
                      ownerData.catName = catName;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "ที่อยู่",
                    style: TextStyle(fontSize: 14),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.zero)),
                    onSaved: (String? address) {
                      ownerData.address = address;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "เบอร์โทรศัพย์เจ้าของ",
                    style: TextStyle(fontSize: 14),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.zero)),
                    onSaved: (String? phoneNumber) {
                      ownerData.phoneNumber = phoneNumber;
                    },
                  ),

                  SizedBox(
                    height: 20,
                  ),

                  //ช่อง upload รูป

                  ownerData.catImages.length != 0
                      ? Text("จำนวนรูปภาพ ${ownerData.catImages.length}")
                      : Text(
                          "ยังไม่มีรูปภาพ",
                          style: TextStyle(color: Colors.red),
                        ),

                  SizedBox(
                    height: 10,
                  ),
                  DottedBorder(
                    color: Colors.blue,
                    strokeWidth: 2,
                    dashPattern: [6, 3],
                    child: TextButton(
                        onPressed: () async {
                          File? imageFile = await _imagePickerHelper.pickImage();
                          if(imageFile != null) {
                            setState(() {
                              ownerData.catImages.add(imageFile.path);
                            });
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add,
                              color: Colors.blue,
                            ),
                            Text(
                              "เพิ่มรูปภาพแมวของคุณ",
                              style: TextStyle(color: Colors.blue),
                            )
                          ],
                        )),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  //ปุ่มตกลง
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5))),
                          onPressed: () {
                            formKey.currentState!.save();
                            print('Save รูป path : ${ownerData.catImages}');
                          },
                          child: Text(
                            "Save",
                            style: TextStyle(color: Colors.white),
                          )),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5))),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Cancel",
                            style: TextStyle(color: Colors.white),
                          )),
                    ],
                  )
                ],
              ),
            )),
      ),
    );
  }
}
