import 'package:catlicense/Func/image_picker_helper.dart';
import 'package:catlicense/model/catdata.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:form_field_validator/form_field_validator.dart';

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
        title: const Text("แบบฟอร์มเจ้าของแมว"),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //ชื่อเจ้าของ
                  const Text(
                    "ชื่อเจ้าของ",
                    style: TextStyle(fontSize: 14),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.zero)),
                    onSaved: (String? fname) {
                      ownerData.firstName = fname;
                    },
                    validator:
                        RequiredValidator(errorText: "กรุณาป้อนชื่อเจ้าของ").call,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  //นามสกุลเจ้าของ
                  const Text(
                    "นามสกุลเจ้าของ",
                    style: TextStyle(fontSize: 14),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.zero)),
                    onSaved: (String? lname) {
                      ownerData.lastName = lname;
                    },
                    validator:
                        RequiredValidator(errorText: "กรุณาป้อนนามสกุลเจ้าของ").call,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  //ชื่อแมว
                  const Text(
                    "ชื่อแมว",
                    style: TextStyle(fontSize: 14),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.zero)),
                    onSaved: (String? catName) {
                      ownerData.catName = catName;
                    },
                    validator: RequiredValidator(errorText: "กรุณาป้อนชื่อแมว").call,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  //ที่อยู่
                  const Text(
                    "ที่อยู่",
                    style: TextStyle(fontSize: 14),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.zero)),
                    onSaved: (String? address) {
                      ownerData.address = address;
                    },
                    validator:
                        RequiredValidator(errorText: "กรุณาป้อนที่อยู่เจ้าของ").call,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  //เบอร์โทรเจ้าของ
                  const Text(
                    "เบอร์โทรศัพย์เจ้าของ",
                    style: TextStyle(fontSize: 14),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.zero)),
                    onSaved: (String? phoneNumber) {
                      ownerData.phoneNumber = phoneNumber;
                    },
                    keyboardType: TextInputType.phone,
                    validator: MultiValidator([
                      RequiredValidator(errorText: "กรุณาป้อนเบอร์เจ้าของแมว"),
                      PatternValidator(r'^(?:[+0]9)?[0-9]{10,12}$',
                          errorText: "กรุณาใส่ตัวเลขที่ถูกต้อง")
                    ]).call,
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  //ช่อง upload รูป

                  ownerData.catImages.isNotEmpty
                      ? Text("จำนวนรูปภาพ ${ownerData.catImages.length}")
                      : const Text(
                          "ยังไม่มีรูปภาพ",
                          style: TextStyle(color: Colors.red),
                        ),

                  const SizedBox(
                    height: 10,
                  ),
                  DottedBorder(
                    color: Colors.blue,
                    strokeWidth: 2,
                    dashPattern: const [6, 3],
                    child: TextButton(
                        onPressed: () async {
                          File? imageFile =
                              await _imagePickerHelper.pickImage();
                          if (imageFile != null) {
                            setState(() {
                              ownerData.catImages.add(imageFile.path);
                            });
                          }
                        },
                        child: const Row(
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
                  const SizedBox(
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
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();
                              print('Save รูป path : ${ownerData.catImages}');
                            }
                          },
                          child: const Text(
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
                          child: const Text(
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
