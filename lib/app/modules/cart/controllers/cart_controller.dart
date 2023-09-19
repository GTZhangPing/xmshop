import 'package:get/get.dart';
import 'package:xmshop/app/services/cartServices.dart';

class CartController extends GetxController {
  //TODO: Implement CartController

  RxList cartList = [].obs;
  RxBool checkedAll = false.obs;
  RxInt totalPrice = 0.obs;
  @override
  void onInit() {
    super.onInit();
    getCartListData();
  }

  void getCartListData() async {
    cartList.value = await CartServices.getCartData();
    checkedAll.value=isCheckedAll();    
    calculatePrice();
    update();
  }

  //增加数量
  incBuyNum(cartItem) {
    List tempList = [];
    for (Map element in cartList) {
      if (element['_id'] == cartItem['_id'] &&
          element['selectedAttr'] == cartItem['selectedAttr']) {
        element['count']++;
      }
      tempList.add(element);
    }
    CartServices.setCartData(tempList);
    update();
  }

  //减少数量
  decBuyNum(cartItem) {
    List tempList = [];
    for (Map element in cartList) {
      if (element['_id'] == cartItem['_id'] &&
          element['selectedAttr'] == cartItem['selectedAttr']) {
        if (element['count'] > 1) {
          element['count']--;
        }
      }
      tempList.add(element);
    }
    CartServices.setCartData(tempList);
    calculatePrice();
    update();
  }

  //选中item
  void checkCartItem(cartItem) {
    List tempList = [];
    for (var element in cartList) {
      if (element['_id'] == cartItem['_id'] &&
          element['selectedAttr'] == cartItem['selectedAttr']) {
        element['checked'] = !element['checked'];
      }
      tempList.add(element);
    }
    checkedAll.value = isCheckedAll();
    CartServices.setCartData(tempList);
    calculatePrice();
    update();
  }

  //全选 反选
  void checkedAllFunc(value) {
    List tempList = [];
    for (var element in cartList) {
      element['checked'] = value;
      tempList.add(element);
    }

    checkedAll.value = value;
    calculatePrice();
    update();
  }

  ///
  bool isCheckedAll() {
    if (cartList.isNotEmpty) {
      bool all = cartList.any((element) {
        return element['checked'] == false;
      });
      return !all;
    }
    return false;
  }

  calculatePrice() {
    // ignore: unused_local_variable
    int price = 0;
    for (var element in cartList) {
      if (element['checked'] == true) {
        price += (element['price'] as int)*(element['count'] as int);
      }
    }
    totalPrice.value = price;
    update();
  }
}
