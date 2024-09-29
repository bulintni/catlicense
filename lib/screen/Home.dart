import 'package:catlicense/firebase_options.dart';
import 'package:catlicense/model/catdata.dart';
import 'package:catlicense/provider/CatViewModel.dart';
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

  @override
  Widget build(BuildContext context) {
    //Data
    // final List<CatsData> catsdata = [
    //   CatsData(
    //       firstName: "Jone",
    //       lastName: "Nema",
    //       address: "address",
    //       phoneNumber: "0922222222",
    //       catName: "Lila",
    //       catImage: "assets/images/cat1.jpg"),
    //   CatsData(
    //       firstName: "Nass",
    //       lastName: "Sala",
    //       address: "address",
    //       phoneNumber: "0933333333",
    //       catName: "Orange",
    //       catImage: "assets/images/cat2.jpg"),
    //   CatsData(
    //       firstName: "Nass",
    //       lastName: "Sala",
    //       address: "address",
    //       phoneNumber: "0933333333",
    //       catName: "Orange",
    //       catImage: "assets/images/cat2.jpg"),
    //   CatsData(
    //       firstName: "Nass",
    //       lastName: "Sala",
    //       address: "address",
    //       phoneNumber: "0933333333",
    //       catName: "Orange",
    //       catImage: "assets/images/cat2.jpg"),
    // ];

    return Container(
      margin: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Card(
            elevation: 0,
            margin: const EdgeInsets.symmetric(vertical: 20),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 150,
                child: Image.asset(
                  'assets/images/BannerTest.png',
                  fit: BoxFit.cover,
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

                          return Card(
                            elevation: 5,
                            margin: EdgeInsets.all(10),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: ListTile(
                                  leading: CircleAvatar(
                                    radius: 30,
                                    backgroundImage: NetworkImage(data["catsImagePath"]),
                                  ),
                                  title: Text("Cat Name : ${data["catName"]}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          "Owner : ${data["fname"]} ${data["lname"]}", style: TextStyle(fontSize: 14),),
                                      Text("PhoneNumber : ${data["phoneNumber"]}", style: TextStyle(fontSize: 12),),
                                    ],
                                  )),
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
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const Formscreen();
                }));
                print('เพิ่มแมวใหม่');
              },
              style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.black26),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Icon(Icons.add), Text("เพิ่มแมวใหม่")],
              ),
            ),
          )
        ],
      ),
    );
  }
}
