import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future addCarDetails(Map<String, dynamic> carInfoMap) async {
    return await FirebaseFirestore.instance
        .collection("cardetails")
        .add(carInfoMap);
  }

  Future getCarInfo(String id) async {
    return await FirebaseFirestore.instance
        .collection("cardetails")
        .where("Id", isEqualTo: id)
        .get();
  }

  Future<void> UpdateInventory(
    String docId,
    String newmodel,
    String newCompany,
    String newcategory,
    String newenginedisplacement,
    String newmaxpower,
    String newmaxtorque,
    String newTransmission,
    String newfueltankcapacity,
    String newFueltype,
    String newgroundclearnce,
    String newgearbox,
    String newprice,
    String newoverview,
    String newzerotohundred,
    String newseatingcapacity,
    String mainimage,
    String displayimage,
    String newnumberplate,
    List<String> newimages,
  ) {
    return FirebaseFirestore.instance
        .collection("cardetails")
        .doc(docId)
        .update({
      'Category': newcategory,
      'Company': newCompany,
      'Transmission': newTransmission,
      'Fuel Type': newFueltype,
      'Model Name': newmodel,
      'Engine Displacement': newenginedisplacement,
      'Maximum Power': newmaxpower,
      'Maximum Torque': newmaxtorque,
      'Zero To Hundred': newzerotohundred,
      'Seating Capacity': newseatingcapacity,
      'Number Plate': newnumberplate,
      'Fuel Tank Capacity': newfueltankcapacity,
      'Ground Clearence': newgroundclearnce,
      'Gearbox': newgearbox,
      'MainImage': mainimage,
      'Price Per Day': newprice,
      'Overview': newoverview,
      'DisplayImage': displayimage,
      'Image Urls': newimages
    });
  }

  Future deleteCarInfo(String docid) async {
    return await FirebaseFirestore.instance
        .collection("cardetails")
        .doc(docid)
        .delete();
  }

  Future addRentalrules(Map<String, String> rentalinfomap) async {
    return await FirebaseFirestore.instance
        .collection("rentalrules")
        .add(rentalinfomap);
  }

  Future deleterentalInfo(String docid) async {
    return await FirebaseFirestore.instance
        .collection("rentalrules")
        .doc(docid)
        .delete();
  }

  Future addnotification(Map<String, dynamic> note) async {
    return await FirebaseFirestore.instance
        .collection("notification")
        .add(note);
  }

  Future Addbookingdetails(Map<String, dynamic> bookinginfomap) async {
    return await FirebaseFirestore.instance
        .collection("booking details")
        .add(bookinginfomap);
  }

  Future addPopularInventories(Map<String, String> popular) async {
    return await FirebaseFirestore.instance
        .collection("popular inventories")
        .add(popular);
  }

  Future deletePopularInventories(String docid) async {
    return await FirebaseFirestore.instance
        .collection("popular inventories")
        .doc(docid)
        .delete();
  }

  Future addtocart(Map<String, dynamic> bookinginfomap) async {
    return await FirebaseFirestore.instance
        .collection("favourites")
        .add(bookinginfomap);
  }

  Future deletecartitem(String ids) async {
    return await FirebaseFirestore.instance
        .collection("favourites")
        .doc(ids)
        .delete();
  }

  Future addtorequestreply(Map<String, dynamic> requestreply) async {
    return await FirebaseFirestore.instance
        .collection("requestreply")
        .add(requestreply);
  }

  Future deleterequest(String ids) async {
    return await FirebaseFirestore.instance
        .collection("booking details")
        .doc(ids)
        .delete();
  }

  Future addprofiledetails(Map<String, dynamic> profile, String docid) async {
    return await FirebaseFirestore.instance
        .collection("profile")
        .doc(docid)
        .set(profile);
  }

  Future addAdvertismentforuser(Map<String, dynamic> add) async {
    return await FirebaseFirestore.instance
        .collection("advertisements")
        .add(add);
  }

  Future<void> UpdateProfile(
      String docid,
      String newname,
      String newage,
      String newbio,
      String newaddress,
      String newpincode,
      String newphonenumber,
      String newprofile,
      String newcover) {
    return FirebaseFirestore.instance
        .collection("Profile")
        .doc(docid)
        .update({
      'fullname': newname,
      'age': newage,
      'bio': newbio,
      'address': newaddress,
      'pincode': newpincode,
      'phonenumber': newphonenumber,
      'profile': newprofile,
      'Cover': newcover,
    });
  }

  Future addprofilepics(Map<String, dynamic> add) async {
    return await FirebaseFirestore.instance.collection("profilepic").add(add);
  }
}
