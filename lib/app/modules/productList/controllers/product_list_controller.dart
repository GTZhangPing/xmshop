import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xmshop/app/models/plist_model.dart';
import 'package:xmshop/app/services/httpsClient.dart';

class ProductListController extends GetxController {
  //TODO: Implement ProductListController

  HttpsClient httpsClient = HttpsClient();
  ScrollController scrollController = ScrollController();
  GlobalKey<ScaffoldState> scaffoldGlobalKey = GlobalKey<ScaffoldState>();

  RxList plist = [].obs;

  int page = 1;
  int pageSize = 10;
  bool flag = true;
  RxBool hasData = true.obs;
  RxInt selectHeaderId = 1.obs;
  //主要解决的问题是排序箭头无法更新
  RxInt subHeaderListSort = 0.obs;
  String sort = '';
/*二级导航数据*/
  List subHeaderList = [
    {
      "id": 1,
      "title": "综合",
      "fileds": "all",
      "sort":
          -1, // 排序     升序：price_1     {price:1}        降序：price_-1   {price:-1}
    },
    {"id": 2, "title": "销量", "fileds": 'salecount', "sort": -1},
    {"id": 3, "title": "价格", "fileds": 'price', "sort": -1},
    {"id": 4, "title": "筛选"}
  ];

  String? keywords = Get.arguments['keywords'];
  String? cid = Get.arguments['cid'];
  String apiUri = "";

  @override
  void onInit() {
    //  print(Get.arguments);
    super.onInit();
    getPlistData();
    initScrollController();
  }

  initScrollController() {
    scrollController.addListener(() {
      // scrollController.position.pixels  滚动条下拉的高度
      // scrollController.position.maxScrollExtent  //页面的高度
      if (scrollController.position.pixels >
          scrollController.position.maxScrollExtent - 20) {
        getPlistData();
      }
    });
  }

  subHeaderChange(id) {
    selectHeaderId.value = id;
    if (id == 4) {
      scaffoldGlobalKey.currentState!.openEndDrawer();
    } else {
      //改变排序  sort=price_-1     sort=price_1
      sort =
          "${subHeaderList[id - 1]["fileds"]}_${subHeaderList[id - 1]["sort"]}";
      //改变状态
      subHeaderList[id - 1]["sort"] = subHeaderList[id - 1]["sort"] * -1;
      //作用更新状态
      subHeaderListSort.value = subHeaderList[id - 1]["sort"];
      //重置page
      page = 1;
      //重置数据
      plist.value = [];
      //重置hasData
      hasData.value = true;
      //滚动条回到顶部
      scrollController.jumpTo(0);
      //重新请求接口
      getPlistData();
    }
    // update();
  }

  getPlistData() async {
    if (flag && hasData.value) {
      flag = false;
      if (cid != null) {
        apiUri = "api/plist?cid=$cid&page=$page&pageSize=$pageSize&sort=$sort";
      } else {
        apiUri =
            "api/plist?search=$keywords&page=$page&pageSize=$pageSize&sort=$sort";
      }
      print(apiUri);
      var response = await httpsClient.get(apiUri);
      if (response != null) {
        var plistTemp = PlistModel.fromJson(response.data);
        plist.addAll(plistTemp.result!);
        page++;
        update();

        flag = true;
        if (plistTemp.result!.length < pageSize) {
          hasData.value = false;
        }
      }
    }
  }
}
