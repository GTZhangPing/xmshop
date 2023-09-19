// ignore_for_file: unnecessary_overrides

import 'package:get/get.dart';
import 'package:xmshop/app/services/searchServices.dart';

import '../../../services/storage.dart';

class SearchsController extends GetxController {
  //TODO: Implement SearchController

  String keywords = '';
  RxList historyList = [].obs;

  @override
  void onInit() {
    super.onInit();
    getHistoryList();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getHistoryList() async {
    List tempList = await SearchServices.getHistoryData();
    if (tempList.isNotEmpty) {
      // historyList.value = tempList;
      historyList.addAll(tempList);
      update();
    }
  }

  clearHistoryData() async {
    await SearchServices.clearHistoryData();
    historyList.clear();
    update();
  }

  removeHistoryData(keywords) async {
    var tempList = await SearchServices.getHistoryData();
    if (tempList.isNotEmpty) {
      tempList.remove(keywords);
      await Storage.setData("searchList", tempList);
      //注意
      historyList.remove(keywords);
      update();
    }
  }
}
