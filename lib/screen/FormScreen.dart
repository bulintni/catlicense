import 'package:catlicense/Func/image_picker_helper.dart';
import 'package:catlicense/firebase_options.dart';
import 'package:catlicense/model/catdata.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:catlicense/Func/pdf_generator.dart';

import 'package:form_field_validator/form_field_validator.dart';
import 'package:image_picker/image_picker.dart';

class Formscreen extends StatefulWidget {
  const Formscreen({super.key});

  @override
  State<Formscreen> createState() => _FormscreenState();
}

class _FormscreenState extends State<Formscreen> {
  final formKey = GlobalKey<FormState>();
  final ImagePickerHelper _imagePickerHelper = ImagePickerHelper();
  final OwnerData ownerData = OwnerData();
  late Future<FirebaseApp> firebase =
      Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final CollectionReference _catsCollection =
      FirebaseFirestore.instance.collection("OwnerCatsData");
  late String imageUrl;
  late File? imageFile;
  bool isLoading = false;

  @override

  // void initState() async {
  //   super.initState();
  //   firebase = Firebase.initializeApp(
  //     options: DefaultFirebaseOptions.currentPlatform
  //   ); // เรียก Firebase.initializeApp() ที่นี่
  // }
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: firebase,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(
                title: Text("Error"),
              ),
              body: Center(
                child: Text("${snapshot.error}"),
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
                appBar: AppBar(
                  title: const Text("แบบฟอร์มเจ้าของแมว"),
                ),
                body: Stack(
                  children: [
                    Container(
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
                                  validator: RequiredValidator(
                                          errorText: "กรุณาป้อนชื่อเจ้าของ")
                                      .call,
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
                                  validator: RequiredValidator(
                                          errorText: "กรุณาป้อนนามสกุลเจ้าของ")
                                      .call,
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
                                  validator: RequiredValidator(
                                          errorText: "กรุณาป้อนชื่อแมว")
                                      .call,
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
                                  validator: RequiredValidator(
                                          errorText: "กรุณาป้อนที่อยู่เจ้าของ")
                                      .call,
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
                                    RequiredValidator(
                                        errorText: "กรุณาป้อนเบอร์เจ้าของแมว"),
                                    PatternValidator(
                                        r'^(?:[+0]9)?[0-9]{10,12}$',
                                        errorText: "กรุณาใส่ตัวเลขที่ถูกต้อง")
                                  ]).call,
                                ),

                                const SizedBox(
                                  height: 20,
                                ),

                                //ช่อง upload รูป

                                ownerData.catImages.isNotEmpty
                                    ? Text(
                                        "จำนวนรูปภาพ ${ownerData.catImages.length}")
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
                                        imageFile = await _imagePickerHelper
                                            .pickImage();
                                        if (imageFile != null) {
                                          setState(() {
                                            ownerData.catImages
                                                .add(imageFile!.path);
                                          });
                                        }
                                      },
                                      child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.add,
                                            color: Colors.blue,
                                          ),
                                          Text(
                                            "เพิ่มรูปภาพแมวของคุณ",
                                            style:
                                                TextStyle(color: Colors.blue),
                                          )
                                        ],
                                      )),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                //ปุ่มตกลง
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.green,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5))),
                                        onPressed: () async {
                                          setState(() {
                                            isLoading = true;
                                          });
                                          print("Save");
                                          String uniqueFileName = DateTime.now()
                                              .microsecondsSinceEpoch
                                              .toString();
                                          print("${uniqueFileName}");
                                          print('${imageFile?.path}');
                                          if (imageFile == null) return;
                                          // สร้าง Storage, Path, Directory, File
                                          Reference referenceRoot =
                                              FirebaseStorage.instance.ref();
                                          Reference referenceDirImages =
                                              referenceRoot.child("Image");
                                          Reference referenceToUpload =
                                              referenceDirImages
                                                  .child(uniqueFileName);

                                          try {
                                            await referenceToUpload
                                                .putFile(File(imageFile!.path));
                                            imageUrl = await referenceToUpload
                                                .getDownloadURL();
                                            if (formKey.currentState!
                                                .validate()) {
                                              formKey.currentState!.save();
                                              PdfGenerator pdfGenerator =
                                                  PdfGenerator();
                                              File pdfFile = await pdfGenerator.generatorAndSavePdf(ownerData, imageUrl);

                                              Reference pdfReferenceRoot = referenceRoot.child("PDFs/$uniqueFileName.pdf");
                                              await pdfReferenceRoot.putFile(pdfFile);
                                              String pdfUrl = await pdfReferenceRoot.getDownloadURL();

                                              await _catsCollection.add({
                                                "fname": ownerData.firstName,
                                                "lname": ownerData.lastName,
                                                "catName": ownerData.catName,
                                                "address": ownerData.address,
                                                "phoneNumber":
                                                    ownerData.phoneNumber,
                                                "catsImagePath": imageUrl,
                                                "pdfUrl": pdfUrl,
                                              });
                                              print('Save เรียบร้อย');
                                              formKey.currentState!.reset();
                                              Navigator.pop(context);
                                            }
                                          } catch (error) {
                                            print("${error}");
                                          } finally {
                                            isLoading = false;
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
                                                borderRadius:
                                                    BorderRadius.circular(5))),
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
                    if (isLoading)
                      Center(
                        child: Container(
                          child: const CircularProgressIndicator(),
                        ),
                      ),
                  ],
                ));
          } else {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}
