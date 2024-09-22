import 'package:catlicense/model/catdata.dart';
import 'package:catlicense/provider/CatViewModel.dart';
import 'package:catlicense/screen/FormScreen.dart';
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
  }
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
      margin: EdgeInsets.all(10),
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "My cats",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.viewModel.catsData.length,
              itemBuilder: (BuildContext context, int index) {
                final cat = widget.viewModel.catsData[index];
                return Container(
                  child: Card(
                    elevation: 5,
                    margin: EdgeInsets.all(10),
                    child: ListTile(
                        leading: CircleAvatar(
                          radius: 40,
                          backgroundImage: AssetImage(cat.catImage),
                        ),
                        title: Text(
                          "Cat Name : ${cat.catName}",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Owner : ${cat.firstName} ${cat.lastName}"),
                            Text("Address : ${cat.address}"),
                            Text("PhoneNumber : ${cat.phoneNumber}"),
                          ],
                        )),
                  ),
                );
              },
            ),
          ),
          Container(
            width: double.infinity,
            height: 50,
            margin: EdgeInsets.symmetric(horizontal: 8),
            child: OutlinedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return Formscreen();
                }));
                print('เพิ่มแมวใหม่');
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Icon(Icons.add), Text("เพิ่มแมวใหม่")],
              ),
              style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.black26),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5))),
            ),
          )
        ],
      ),
    );
  }
}
