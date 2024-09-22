class CatsData {
  final String firstName;
  final String lastName;
  final String address;
  final String phoneNumber;
  final String catName;
  final String catImage;
  CatsData({
    required this.firstName,
    required this.lastName,
    required this.address,
    required this.phoneNumber,
    required this.catName,
    required this.catImage,
  });
}

class OwnerData {
  String? firstName;
  String? lastName;
  String? address;
  String? phoneNumber;
  String? catName;
  List<String> catImages;
  OwnerData({
    this.firstName,
    this.lastName,
    this.address,
    this.phoneNumber,
    this.catName,
    List<String>? catImages,
  }) : catImages = catImages ?? [];
}