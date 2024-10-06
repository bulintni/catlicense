import 'package:catlicense/firebase_options.dart';
import 'package:catlicense/model/catdata.dart';
import 'package:catlicense/provider/CatViewModel.dart';
import 'package:catlicense/screen/DetailLicence.dart';
import 'package:catlicense/screen/FormScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  late CatViewModel viewModel;
  Home({super.key, required this.viewModel});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    widget.viewModel.fetchCatsData();
    // initializeFirebase();
  }

  void showFormOverlay(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: SizedBox(
            width: double.maxFinite,
            child: Formscreen(), // เรียกใช้ FormScreen ที่อยู่ในไฟล์อื่น
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Card(
            elevation: 0,
            margin: const EdgeInsets.symmetric(vertical: 20),
            color: Colors.green.shade50,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 150,
                child: Center(
                  child: Text(
                    "พื้นที่โฆษณา",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "My cats",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
              ],
            ),
          ),
          StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("OwnerCatsData")
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text("Has Error");
                } else {
                  return Expanded(
                    child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final document = snapshot.data!.docs[index];
                          final data = document.data() as Map<String, dynamic>;
                          final pdfUrl = data["pdfUrl"];

                          return Card(
                            color: Colors.white,
                            elevation: 2,
                            margin: EdgeInsets.all(10),
                            child: InkWell(
                              onTap: () async {
                                var catImage = data["catsImagePath"];
                                var catName = data["catName"];
                                var fname = data["fname"];
                                var lname = data["lname"];
                                var address = data["address"];
                                var phoneNumber = data["phoneNumber"];
                                var pdfUrl = data["pdfUrl"];
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailLicence(
                                      catsImagePath: catImage,
                                      catName: catName,
                                      fname: fname,
                                      lname: lname,
                                      address: address,
                                      phoneNumber: phoneNumber,
                                      pdfUrl: pdfUrl,
                                    ),
                                  ),
                                );
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                child: ListTile(
                                    leading: CircleAvatar(
                                      radius: 30,
                                      backgroundImage:
                                          NetworkImage(data["catsImagePath"]),
                                    ),
                                    title: Text(
                                      "Cat Name : ${data["catName"]}",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Owner : ${data["fname"]} ${data["lname"]}",
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        Text(
                                          "PhoneNumber : ${data["phoneNumber"]}",
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ],
                                    )),
                              ),
                            ),
                          );
                        }),
                  );
                }
              }),
          // Expanded(
          //   child: ListView.builder(
          //     itemCount: widget.viewModel.catsData.length,
          //     itemBuilder: (BuildContext context, int index) {
          //       final cat = widget.viewModel.catsData[index];
          //       return Container(
          //         child: Card(
          //           elevation: 5,
          //           margin: const EdgeInsets.all(10),
          //           child: ListTile(
          //               leading: CircleAvatar(
          //                 radius: 40,
          //                 backgroundImage: AssetImage(cat.catImage),
          //               ),
          //               title: Text(
          //                 "Cat Name : ${cat.catName}",
          //                 style: const TextStyle(fontWeight: FontWeight.bold),
          //               ),
          //               subtitle: Column(
          //                 crossAxisAlignment: CrossAxisAlignment.start,
          //                 children: [
          //                   Text("Owner : ${cat.firstName} ${cat.lastName}"),
          //                   Text("Address : ${cat.address}"),
          //                   Text("PhoneNumber : ${cat.phoneNumber}"),
          //                 ],
          //               )),
          //         ),
          //       );
          //     },
          //   ),
          // ),
          Container(
            width: double.infinity,
            height: 50,
            margin: const EdgeInsets.symmetric(horizontal: 8),
            child: OutlinedButton(
              onPressed: () {
                // Navigator.push(context, MaterialPageRoute(builder: (context) {
                //   return const Formscreen();
                // }));
                showFormOverlay(context);
                print('เพิ่มแมวของคุณ');
              },
              style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.black26),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add,
                    color: Colors.black,
                  ),
                  Text(
                    "เพิ่มแมวของคุณ",
                    style: TextStyle(color: Colors.black),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
