import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xmshop/app/models/focus_model.dart';
import 'package:xmshop/app/models/plist_model.dart';
import 'package:xmshop/app/services/httpsClient.dart';
import '../../../models/category_model.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  RxBool flag = false.obs;
  ScrollController scrollController = ScrollController();
  HttpsClient httpsClient = HttpsClient();

  RxList swiperList = [].obs;
  RxList categoryList = [].obs;
  RxList bestSellingSwiperList = [].obs;
  RxList sellingPlist = [].obs;
  RxList bestPlist = [].obs;
  @override
  void onInit() {
    super.onInit();
    scrollControllerListener();
    getFocusData();
    getCategory();
    getSellingSwiperData();
    getSellingPlistData();
    getBestPlistData();
  }

  scrollControllerListener() {
    scrollController.addListener(() {
      if (scrollController.position.pixels > 10 && flag.value == false) {
        flag.value = true;
        update();
      } else if (scrollController.position.pixels < 10 && flag.value == true) {
        flag.value = false;
        update();
      }
    });
  }

  getFocusData() async {
    // var response = await Dio().get('https://xiaomi.itying.com/api/focus');
    // print(response.data);
    var response = await httpsClient.get('api/focus');
    if (response != null) {
      var focus = FocusModel.fromJson(response.data);
      swiperList.value = focus.result!;
      update();
    }
  }

  getCategory() async {
    var response = await httpsClient.get('api/bestCate');
    var category = CategoryModel.fromJson(response.data);
    categoryList.value = category.result!;
    update();
    //
  }

  getSellingSwiperData() async {
    var response =
        await httpsClient.get('api/focus?position=2');
    print(response.data);

    var focus = FocusModel.fromJson(response.data);
    bestSellingSwiperList.value = focus.result!;
    update();
  }

  getSellingPlistData() async {
    var response =
        await httpsClient.get('api/plist?is_hot=1');
    var plist = PlistModel.fromJson(response.data);
    sellingPlist.value = plist.result!;
    update();
  }

  getBestPlistData() async {
    var response =
        await httpsClient.get('api/plist?is_best=1');
    var plist = PlistModel.fromJson(response.data);
    bestPlist.value = plist.result!;
    update();
  }
}
