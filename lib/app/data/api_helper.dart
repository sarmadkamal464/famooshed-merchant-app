import 'package:get/get.dart';

export 'package:famooshed_vendor/app/common/util/extensions.dart';
export 'package:famooshed_vendor/app/common/util/utils.dart';

abstract class ApiHelper {
  static ApiHelper get to => Get.find();

  Future<Response> getPosts();
  Future<Response> postApi(url, body);
  Future<Response> getApi(url);
}
