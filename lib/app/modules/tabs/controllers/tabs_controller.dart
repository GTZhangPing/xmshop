import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xmshop/app/modules/cart/views/cart_view.dart';
import 'package:xmshop/app/modules/category/views/category_view.dart';
import 'package:xmshop/app/modules/give/views/give_view.dart';
import 'package:xmshop/app/modules/home/views/home_view.dart';
import 'package:xmshop/app/modules/user/views/user_view.dart';

class TabsController extends GetxController {
  //TODO: Implement TabsController

  RxInt currentIndex = 0.obs;
  final List<Widget> pages = [
    const HomeView(),
    const CategoryView(),
    const GiveView(),
    CartView(),
    const UserView(),
  ];

  PageController pageController = PageController(initialPage: 0);

  final count = 0.obs;
}
