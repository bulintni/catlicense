import 'package:catlicense/model/catdata.dart';
import 'package:flutter/foundation.dart';

class CatViewModel extends ChangeNotifier {
  List<CatsData> _catsData = [];

  List<CatsData> get catsData => _catsData;

  void fetchCatsData() {
    _catsData = [
      CatsData(
          firstName: "Jone",
          lastName: "Nema",
          address: "address",
          phoneNumber: "0922222222",
          catName: "Lila",
          catImage: "assets/images/cat1.jpg"),
      CatsData(
          firstName: "Nass",
          lastName: "Sala",
          address: "address",
          phoneNumber: "0933333333",
          catName: "Orange",
          catImage: "assets/images/cat2.jpg"),
      CatsData(
          firstName: "Nass",
          lastName: "Sala",
          address: "address",
          phoneNumber: "0933333333",
          catName: "Orange",
          catImage: "assets/images/cat2.jpg"),
      CatsData(
          firstName: "Nass",
          lastName: "Sala",
          address: "address",
          phoneNumber: "0933333333",
          catName: "Orange",
          catImage: "assets/images/cat2.jpg"),
    ];

    notifyListeners();
  }
}