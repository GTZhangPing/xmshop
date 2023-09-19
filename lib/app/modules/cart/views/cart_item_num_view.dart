import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:xmshop/app/modules/cart/controllers/cart_controller.dart';
import 'package:xmshop/app/services/screenAdapter.dart';

class CartItemNumView extends GetView {
  @override
  final CartController controller = Get.find();
  final Map cartItem;
   CartItemNumView(this.cartItem, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenAdapter.width(244),
      height: ScreenAdapter.height(60),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.black12,
          width: ScreenAdapter.width(2),
        ),
      ),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              controller.decBuyNum(cartItem);
            },
            child: Container(
            alignment: Alignment.center,
            width: ScreenAdapter.width(70),
            child: const Text('-'),
          ),
          ),
          Container(
            alignment: Alignment.center,
            width: ScreenAdapter.width(90),
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(
                    color: Colors.black12, width: ScreenAdapter.width(2)),
                right: BorderSide(
                    color: Colors.black12, width: ScreenAdapter.width(2)),
              ),
            ),
            child: Text('${cartItem["count"]}'),
          ),
          InkWell(
            onTap: () {
              controller.incBuyNum(cartItem);
            },
            child: Container(
            alignment: Alignment.center,
            width: ScreenAdapter.width(70),
            child: const Text('+'),
          ),
          ),
        ],
      ),
    );
  }
}
