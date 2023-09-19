import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:get/get.dart';
import 'package:xmshop/app/routes/app_pages.dart';
import 'package:xmshop/app/services/httpsClient.dart';
import 'package:xmshop/app/services/keepAliveWrapper.dart';
import 'package:xmshop/app/services/screenAdapter.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return KeepAliveWrapper(
        child: Scaffold(
            body: Stack(
      children: [_homePage(), _appBar()],
    )));
  }

  Widget _appBar() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Obx(() {
        return AppBar(
          leading: controller.flag.value
              ? const Text("")
              : const Icon(
                  Icons.abc,
                  color: Colors.white,
                ),
          leadingWidth: controller.flag.value
              ? ScreenAdapter.width(40)
              : ScreenAdapter.width(140),
          title: InkWell(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: controller.flag.value
                  ? ScreenAdapter.width(800)
                  : ScreenAdapter.width(620),
              height: ScreenAdapter.height(96),
              decoration: BoxDecoration(
                  color: const Color.fromARGB(230, 252, 243, 236),
                  borderRadius: BorderRadius.circular(30)),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Icon(
                      Icons.search,
                      color: Colors.black54,
                    ),
                  ),
                  Text("手机",
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: ScreenAdapter.fontSize(40)))
                ],
              ),
            ),
            onTap: () {
              Get.toNamed(Routes.SEARCH);
            },
          ),
          centerTitle: true,
          backgroundColor:
              controller.flag.value ? Colors.white : Colors.transparent,
          elevation: 0, //阴影去掉
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.qr_code,
                  color: controller.flag.value ? Colors.black : Colors.white,
                )),
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.message,
                  color: controller.flag.value ? Colors.black : Colors.white,
                ))
          ],
        );
      }),
    );
  }

  Widget _homePage() {
    return Positioned(
      top: -ScreenUtil().statusBarHeight,
      left: 0,
      right: 0,
      bottom: 0,
      child: ListView(
        controller: controller.scrollController,
        children: [
          _focus(),
          _banner1(),
          _category(),
          _banner2(),
          _bestSelling(),
          _bestGoods(),
          const SizedBox(
            height: 100,
          )
        ],
      ),
    );
  }

  Widget _focus() {
    return SizedBox(
      width: ScreenAdapter.getScreenWidth(),
      height: ScreenAdapter.height(682),
      child: Obx(() {
        return Swiper(
          itemBuilder: (context, index) {
            return Image.network(
              HttpsClient.replaeUri(controller.swiperList[index].pic),
              fit: BoxFit.cover,
            );
          },
          itemCount: controller.swiperList.length,
          autoplay: true,
          loop: true,
          pagination: const SwiperPagination(builder: SwiperPagination.rect),
          // control: const SwiperControl(),
        );
      }),
    );
  }

  Widget _banner1() {
    return SizedBox(
      width: ScreenAdapter.getScreenWidth(),
      height: ScreenAdapter.height(92),
      child: Image.asset(
        "assets/images/xiaomiBanner.png",
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _category() {
    return SizedBox(
      width: ScreenAdapter.getScreenWidth(),
      height: ScreenAdapter.height(480),
      // color: Colors.red,
      child: Obx(() {
        return Swiper(
          itemCount: controller.categoryList.length ~/ 10,
          pagination: SwiperPagination(
              margin: const EdgeInsets.all(0.0),
              builder: SwiperCustomPagination(
                  builder: (BuildContext context, SwiperPluginConfig config) {
                return ConstrainedBox(
                  constraints:
                      BoxConstraints.expand(height: ScreenAdapter.height(20)),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Align(
                          alignment: Alignment.center,
                          child: const RectSwiperPaginationBuilder(
                            color: Colors.black12,
                            activeColor: Colors.black54,
                          ).build(context, config),
                        ),
                      )
                    ],
                  ),
                );
              })),
          itemBuilder: (context, index) {
            return GridView.builder(
                itemCount: 10,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    crossAxisSpacing: ScreenAdapter.width(20),
                    mainAxisSpacing: ScreenAdapter.height(20)),
                itemBuilder: (context, i) {
                  return Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        width: ScreenAdapter.height(140),
                        height: ScreenAdapter.height(140),
                        // color: Colors.red,
                        child: Image.network(
                            HttpsClient.replaeUri(
                                controller.categoryList[index * 10 + i].pic),
                            fit: BoxFit.fitHeight),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            0, ScreenAdapter.height(5), 0, 0),
                        child: Text(
                          '${controller.categoryList[index * 10 + i].title}',
                          style:
                              TextStyle(fontSize: ScreenAdapter.fontSize(34)),
                        ),
                      ),
                    ],
                  );
                });
          },
        );
      }),
    );
  }

  Widget _banner2() {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          ScreenAdapter.width(20),
          ScreenAdapter.height(20),
          ScreenAdapter.width(20),
          ScreenAdapter.height(20)),
      child: Container(
        height: ScreenAdapter.height(440),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(ScreenAdapter.width(20)),
            image: const DecorationImage(
                image: AssetImage("assets/images/xiaomiBanner2.png"),
                fit: BoxFit.cover)),
      ),
    );
  }

  Widget _bestSelling() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(
              ScreenAdapter.width(30),
              ScreenAdapter.height(20),
              ScreenAdapter.width(30),
              ScreenAdapter.height(20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("热销臻选",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: ScreenAdapter.fontSize(46))),
              Text("更多手机推荐 >",
                  style: TextStyle(fontSize: ScreenAdapter.fontSize(38)))
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(ScreenAdapter.width(30),
              ScreenAdapter.height(20), ScreenAdapter.width(30), 0),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: SizedBox(
                  height: ScreenAdapter.height(738),
                  child: Obx(() {
                    return Swiper(
                      itemCount: controller.bestSellingSwiperList.length,
                      autoplay: true,
                      loop: true,
                      pagination: const SwiperPagination(
                          builder: SwiperPagination.rect),
                      itemBuilder: (context, index) {
                        return Image.network(
                          HttpsClient.replaeUri(
                              controller.bestSellingSwiperList[index].pic),
                          fit: BoxFit.cover,
                        );
                      },
                    );
                  }),
                ),
              ),
              SizedBox(
                width: ScreenAdapter.width(20),
              ),
              Expanded(
                  flex: 1,
                  child: SizedBox(
                    height: ScreenAdapter.height(738),
                    // color: Colors.red,
                    child: Obx(() {
                      return Column(
                        children: controller.sellingPlist
                            .asMap()
                            .entries
                            .map((entrie) {
                          var value = entrie.value;
                          return Expanded(
                              flex: 1,
                              child: Container(
                                color: const Color.fromRGBO(246, 246, 246, 1),
                                margin: EdgeInsets.fromLTRB(
                                    0,
                                    0,
                                    0,
                                    entrie.key == 2
                                        ? 0
                                        : ScreenAdapter.height(20)),
                                child: Row(
                                  children: [
                                    Expanded(
                                        flex: 3,
                                        child: Column(
                                          children: [
                                            SizedBox(
                                                height:
                                                    ScreenAdapter.height(20)),
                                            Text("${value.title}",
                                                style: TextStyle(
                                                    fontSize:
                                                        ScreenAdapter.fontSize(
                                                            38),
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            SizedBox(
                                                height:
                                                    ScreenAdapter.height(20)),

                                            Text("${value.subTitle}",
                                                style: TextStyle(
                                                    fontSize:
                                                        ScreenAdapter.fontSize(
                                                            28))),
                                            SizedBox(
                                                height:
                                                    ScreenAdapter.height(20)),

                                            Text("￥${value.price}元",
                                                style: TextStyle(
                                                    fontSize:
                                                        ScreenAdapter.fontSize(
                                                            34))),
                                            //         SizedBox(
                                            // height: ScreenAdapter.height(25)),
                                          ],
                                        )),
                                    Expanded(
                                      flex: 2,
                                      child: Padding(
                                        padding: EdgeInsets.all(
                                            ScreenAdapter.height(8)),
                                        child: Image.network(
                                            HttpsClient.replaeUri(value.pic),
                                            fit: BoxFit.cover),
                                      ),
                                    )
                                  ],
                                ),
                              ));
                        }).toList(),
                      );
                    }),
                  )),
            ],
          ),
        ),
      ],
    );
  }

  Widget _bestGoods() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(
              ScreenAdapter.width(30),
              ScreenAdapter.height(20),
              ScreenAdapter.width(30),
              ScreenAdapter.height(20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("省心优惠",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: ScreenAdapter.fontSize(46))),
              Text("全部优惠 >",
                  style: TextStyle(fontSize: ScreenAdapter.fontSize(38)))
            ],
          ),
        ),
        Obx(() {
          return Container(
            padding: EdgeInsets.all(ScreenAdapter.width(20)),
            color: const Color.fromRGBO(246, 246, 246, 1),
            child: MasonryGridView.count(
              crossAxisCount: 2,
              itemCount: controller.bestPlist.length,
              mainAxisSpacing: ScreenAdapter.width(20),
              crossAxisSpacing: ScreenAdapter.width(20),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return InkWell(
                  child: Container(
                    // height: height,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(ScreenAdapter.width(10)),
                          child: Image.network(
                            HttpsClient.replaeUri(
                                controller.bestPlist[index].sPic),
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(ScreenAdapter.width(10)),
                          width: double.infinity,
                          child: Text("${controller.bestPlist[index].title}"),
                        ),
                        Container(
                          padding: EdgeInsets.all(ScreenAdapter.width(10)),
                          width: double.infinity,
                          child:
                              Text("${controller.bestPlist[index].subTitle}"),
                        ),
                        Container(
                          padding: EdgeInsets.all(ScreenAdapter.width(10)),
                          width: double.infinity,
                          child: Text(
                            "¥${controller.bestPlist[index].price}",
                          ),
                        )
                      ],
                    ),
                  ),
                  onTap: () {
                    Get.toNamed(Routes.PRODUCT_CONTENT,
                        arguments: {'id': controller.bestPlist[index].sId});
                  },
                );
              },
            ),
          );
        }),
      ],
    );
  }
}
