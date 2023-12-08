import 'dart:math';

import 'package:famooshed_vendor/app/common/constants.dart';

String getImageUrl(String? img) {
  var url = Constants.imgUrl + img!;
  return url;
}

String getPrice(String amount) {
  var finalAmount = '£$amount';
  return finalAmount;
}

class ImageFilesData {
  String id = "0";
  String localFile;
  String serverFile;

  ImageFilesData(this.id, this.localFile, this.serverFile);
}

double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
  var p = 0.017453292519943295;
  var c = cos;
  var a = 0.5 -
      c((lat2 - lat1) * p) / 2 +
      c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
  return 12742 * asin(sqrt(a));
}
