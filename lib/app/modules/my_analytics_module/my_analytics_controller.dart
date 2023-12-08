import 'dart:ui';

import 'package:famooshed_vendor/app/common/values/app_url.dart';
import 'package:famooshed_vendor/app/data/models/analytics_model.dart';
import 'package:get/get.dart';

import '../../common/util/loading_dialog.dart';
import '../../common/values/app_colors.dart';
import '../../data/api_helper.dart';

class MyAnalyticsController extends GetxController {
  // List<SalesData> data = [
  //   SalesData('Jan', 35),
  //   SalesData('Feb', 28),
  //   SalesData('Mar', 34),
  //   SalesData('Apr', 32),
  //   SalesData('May', 40)
  // ];

  final _apiHelper = ApiHelper.to;

  @override
  void onReady() {
    getAnalyticsData();
    super.onReady();
  }

  RxInt pageNo = RxInt(1);
  RxInt lastPageIndex = RxInt(1);

  AnalyticsModel analyticsModel = AnalyticsModel();

  List<TopSellingProductModel> topSellingProducts = [];
  ProductSell productSell = ProductSell();

  TopSellingProductModel topSell = TopSellingProductModel();

  Future<void> getAnalyticsData() async {
    LoadingDialog.showLoadingDialog();
    try {
      Uri uri = Uri.parse(AppUrl.analytics)
          .replace(queryParameters: {"page": pageNo.value.toString()});
      Response response = await _apiHelper.postApi(uri.toString(), {});
      if (response.statusCode == 200) {
        if (response.body['error'] != null && response.body['error'] == '0') {
          analyticsModel = AnalyticsModel.fromJson(response.body['data']);
          if (analyticsModel.productSell != null) {
            productSell = analyticsModel.productSell!;
            lastPageIndex.value = productSell.lastPage ?? 1;
            if (productSell.data != null) {
              topSellingProducts = productSell.data!;
              if (topSellingProducts.isNotEmpty) {
                if (pageNo.value == 1) {
                  topSell = topSellingProducts.first;
                }
              }
            }
          }
          update();
          LoadingDialog.closeLoadingDialog();
        } else {
          Utils.showSnackbar(
              response.body['message'] ?? "Error fetching analytics");
        }
      }
    } catch (e) {
      print(e.toString());
      LoadingDialog.closeLoadingDialog();
    }
  }

  getProductStatus(TopSellingProductModel food) {
    String status = "Inactive";
    if (food.published == 0) {
      status = "Inactive";
    } else {
      if (food.inventoryStock != null && food.inventoryStock! > 0) {
        status = "Active";
      } else {
        status = "Out of Stock";
      }
    }
    return status;
  }

  Color getProductColor(TopSellingProductModel food) {
    Color color = AppColors.lightYellow;
    if (food.published == 0) {
      color = AppColors.greyText.withOpacity(.4);
    } else {
      if (food.inventoryStock != null && food.inventoryStock! > 0) {
        color = AppColors.lightGreen;
      } else {
        color = AppColors.lightRed;
      }
    }
    return color;
  }
}
