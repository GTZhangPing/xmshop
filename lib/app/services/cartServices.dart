import 'package:xmshop/app/services/storage.dart';

import '../models/pcontent_model.dart';

class CartServices {
//增加购物车
  static addCart(
      PcontentItemModel pcontent, String selectedAttr, int buyNum) async {
    List? cartListData = await Storage.getData("cartList");
    if (cartListData!.isNotEmpty) {
      var hasData = cartListData.any((value) {
        return value['_id'] == pcontent.sId &&
            value['selectedAttr'] == selectedAttr;
      });
      if (hasData) {
        for (Map map in cartListData) {
          if (map['_id'] == pcontent.sId &&
              map['selectedAttr'] == selectedAttr) {
            map['count'] += buyNum;
          }
        }
        await Storage.setData("cartList", cartListData);
      } else {
        cartListData.add({
          "_id": pcontent.sId,
          "title": pcontent.title,
          "price": pcontent.price,
          "selectedAttr": selectedAttr,
          "count": buyNum,
          "pic": pcontent.pic,
          "checked": true
        });
        await Storage.setData('cartList', cartListData);
      }
    } else {
      List tempList = [];
      tempList.add({
        "_id": pcontent.sId,
        "title": pcontent.title,
        "price": pcontent.price,
        "selectedAttr": selectedAttr,
        "count": buyNum,
        "pic": pcontent.pic,
        "checked": true
      });
      await Storage.setData('cartList', tempList);
    }
  }

//获取购物车列表
  static getCartData() async {
    List? cartListData = await Storage.getData("cartList");
    if (cartListData != null) {
      return cartListData;
    } else {
      return [];
    }
  }

  static setCartData(cartListData) async {
    await Storage.setData('cartList', cartListData);
  }

  // 获取选中的CartList数据
  static getCheckedCartData() async {
    List tempList = [];
    List? cartListData = await Storage.getData("cartList");
    for (var temp in cartListData!) {
      if (temp['checked'] == true) {
        tempList.add(temp);
      }
    }
    return tempList;
  }

  //清空搜索记录
  static clearCartData() async {
    await Storage.deleteData('cartList');
  }

  static deleteChectoutList(checkoutList) async {
    List? cartListData = await Storage.getData("cartList");
    if (cartListData != null) {
      List tempList = [];
      for (Map element in cartListData) {
        if (!hasCheckOutData(checkoutList, element)) {
          tempList.add(element);
        }
      }
      Storage.setData('cartList', tempList);
    }
  }

  static hasCheckOutData(checkOutList, cartItem) {
    for (var element in checkOutList) {
      if (element['_id'] == cartItem['_id']) {
        return true;
      }
    }
    return false;
  }
}
