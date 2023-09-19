import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:xmshop/app/services/cartServices.dart';
import 'package:xmshop/app/services/screenAdapter.dart';

import '../controllers/cart_controller.dart';
import 'cart_item_view.dart';

class CartView extends GetView {
  @override
  final CartController controller = Get.put(CartController());
  CartView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('购物车'),
        centerTitle: true,
        actions: [
          TextButton(
              onPressed: () {
                CartServices.clearCartData();
              },
              child: const Text('编辑'))
        ],
      ),
      body: GetBuilder<CartController>(
        initState: (state) {
          controller.getCartListData();
        },
        init: controller,
        builder: (controller) {
          return controller.cartList.isNotEmpty
              ? Stack(
                  children: [
                    ListView(
                      padding:
                          EdgeInsets.only(bottom: ScreenAdapter.height(200)),
                      children: controller.cartList.map((cartItem) {
                        return CartItemView(cartItem);
                      }).toList(),
                    ),
                    Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Container(
                          padding:
                              EdgeInsets.only(right: ScreenAdapter.width(20)),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border(
                                  top: BorderSide(
                                      color: Colors.black12,
                                      width: ScreenAdapter.width(2)))),
                          height: ScreenAdapter.height(160),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Checkbox(
                                    activeColor: Colors.red,
                                      value: controller.checkedAll.value,
                                      onChanged: (value) {
                                        controller.checkedAllFunc(value);
                                      }),
                                  const Text('全选'),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text("合计: "),
                                  Text('${controller.totalPrice.value}',
                                      style: TextStyle(
                                          fontSize: ScreenAdapter.fontSize(58),
                                          color: Colors.red)),
                                  SizedBox(width: ScreenAdapter.width(20)),
                                  ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.red),
                                        foregroundColor:
                                            MaterialStateProperty.all(
                                                Colors.white),
                                        shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20))),
                                      ),
                                      onPressed: () {},
                                      child: const Text('结算')),
                                ],
                              )
                            ],
                          ),
                        )),
                  ],
                )
              : const Center(
                  child: Text('暂无数据'),
                );
        },
      ),
    );
  }
}
