import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xmshop/app/models/pcontent_model.dart';
import 'package:xmshop/app/routes/app_pages.dart';
import 'package:xmshop/app/services/cartServices.dart';
import 'package:xmshop/app/services/httpsClient.dart';
import 'package:xmshop/app/services/screenAdapter.dart';
import 'package:xmshop/app/services/storage.dart';
import 'package:xmshop/app/services/userServices.dart';

class ProductContentController extends GetxController {
  //TODO: Implement ProductContentController

  ScrollController scrollController = ScrollController();
  HttpsClient httpsClient = HttpsClient();

  GlobalKey gk1 = GlobalKey();
  GlobalKey gk2 = GlobalKey();
  GlobalKey gk3 = GlobalKey();

  RxDouble opacity = 0.0.obs;

  //是否显示tabs
  RxBool showTabs = false.obs;

  var pcontent = PcontentItemModel().obs;
  RxList pcontentAttr = [].obs;

  List tabsList = [
    {
      "id": 1,
      "title": "商品",
    },
    {"id": 2, "title": "详情"},
    {"id": 3, "title": "推荐"}
  ];
  RxInt selectedTabsIndex = 1.obs;

  List subTabsList = [
    {
      "id": 1,
      "title": "商品介绍",
    },
    {"id": 2, "title": "规格参数"},
  ];
  RxInt selectedSubTabsIndex = 1.obs;

  double gk2Position = 0.0;
  double gk3Position = 0.0;
  RxBool showSubHeaderTabs = false.obs;

//保存筛选属性值
  RxString selectedAttr = "".obs;
  //购买的数量
  RxInt buyNum = 1.obs;

  @override
  void onInit() {
    super.onInit();
    scrollControllerAddListener();
    getContentData();
  }

  scrollControllerAddListener() {
    scrollController.addListener(() {
      if (gk2Position == 0.0 && gk3Position == 0.0) {
        RenderBox box2 = gk2.currentContext!.findRenderObject() as RenderBox;
        gk2Position = box2.localToGlobal(Offset.zero).dy +
            scrollController.position.pixels -
            (ScreenAdapter.getStatusBarHeight() + ScreenAdapter.height(120));
        RenderBox box3 = gk3.currentContext!.findRenderObject() as RenderBox;
        gk3Position = box3.localToGlobal(Offset.zero).dy +
            scrollController.position.pixels -
            (ScreenAdapter.getStatusBarHeight() + ScreenAdapter.height(120));
      }

      if (scrollController.position.pixels < gk2Position) {
        if (showSubHeaderTabs.value) {
          showSubHeaderTabs.value = false;
          selectedTabsIndex.value = 1;
        }
      } else if (scrollController.position.pixels > gk2Position &&
          scrollController.position.pixels < gk3Position) {
        if (!showSubHeaderTabs.value) {
          showSubHeaderTabs.value = true;
          selectedTabsIndex.value = 2;
        }
      } else if (scrollController.position.pixels > gk3Position) {
        if (showSubHeaderTabs.value) {
          showSubHeaderTabs.value = false;
          selectedTabsIndex.value = 3;
        }
      }

      if (scrollController.position.pixels <= 0) {
        opacity.value = 0.0;
        update();
      } else if (scrollController.position.pixels <= 100) {
        opacity.value = scrollController.position.pixels / 100;
        // print(scrollController.position.pixels);
        // print(opacity.value);
        if (showTabs.value == true) {
          showTabs.value = false;
        }
        update();
      } else {
        if (opacity.value != 1.0) {
          opacity.value = 1.0;
        }
        if (showTabs.value == false) {
          showTabs.value = true;
        }
      }
    });
  }

  //改变顶部tab切换
  changeSelectedTabsIndex(index) {
    selectedTabsIndex.value = index;
    update();
  }

  changeSelectedSubTabsIndex(index) {
    selectedSubTabsIndex.value = index;
    update();
    scrollController.jumpTo(gk2Position);
  }

  //获取详情数据
  getContentData() async {
    var response =
        await httpsClient.get('api/pcontent?id=${Get.arguments['id']}');
    print(response);
    if (response != null) {
      var tempDate = PcontentModel.fromJson(response.data);
      pcontent.value = tempDate.result!;
      pcontentAttr.value = pcontent.value.attr!;
      initAttr(pcontentAttr);
      setSelectedAttr();
      update();
    }
  }

  initAttr(attr) {
    for (var i = 0; i < attr.length; i++) {
      for (var j = 0; j < attr[i].list.length; j++) {
        if (j == 0) {
          attr[i].checkList!.add(true);
        } else {
          attr[i].checkList!.add(false);
        }
      }
    }
  }

  changeAttr(cate, index) {
    print(cate);
    print(index);
    for (PcontentAttrModel attr in pcontentAttr) {
      if (attr.cate == cate) {
        for (var i = 0; i < attr.checkList!.length; i++) {
          if (i == index) {
            attr.checkList![i] = true;
          } else {
            attr.checkList![i] = false;
          }
        }
      }
    }
    // print(pcontentAttr);
    update();
  }

  setSelectedAttr() {
    List tempList = [];
    for (var i = 0; i < pcontentAttr.length; i++) {
      for (var j = 0; j < pcontentAttr[i].checkList.length; j++) {
        if (pcontentAttr[i].checkList[j] == true) {
          tempList.add(pcontentAttr[i].list[j]);
        }
      }
    }
    // tempList.add('${buyNum.value}件');
    selectedAttr.value = tempList.join(",");
    update();
  }

  //增加数量
  incBuyNum() {
    buyNum.value++;
    update();
  }

  //减少数量
  decBuyNum() {
    if (buyNum.value > 1) {
      buyNum.value--;
      update();
    }
  }

  void addCart() {
    setSelectedAttr();
    print("加入购物车");
    Get.back();
    CartServices.addCart(pcontent.value, selectedAttr.value, buyNum.value);
    Get.snackbar('提示', '加入购物车成功');
  }

  void buy() async {
    setSelectedAttr();
    // print("立即购买");
    Get.back();

    List tempLit = [];
    tempLit.add({
      "_id": pcontent.value.sId,
      "title": pcontent.value.title,
      "price": pcontent.value.price,
      "selectedAttr": selectedAttr.value,
      "count": buyNum.value,
      "pic": pcontent.value.pic,
      "checked": true
    });
    Storage.setData('checkoutList', tempLit);
    bool loginState = await UserServices.getUserLoginState();
    if (loginState) {
      Get.toNamed(Routes.CHECTOUT);
    } else {
      Get.toNamed(Routes.CODE_LOGIN_STEP_ONE);
      Get.snackbar('提示', '您还未登陆');
    }
  }
}
