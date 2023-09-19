
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:xmshop/app/routes/app_pages.dart';
import 'package:xmshop/app/services/httpsClient.dart';
import 'package:xmshop/app/services/keepAliveWrapper.dart';
import 'package:xmshop/app/services/screenAdapter.dart';

import '../controllers/category_controller.dart';

class CategoryView extends GetView<CategoryController> {
  const CategoryView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return KeepAliveWrapper(
        child: Scaffold(
      appBar: AppBar(
        title: InkWell(
          child: Container(
          height: ScreenAdapter.height(96),
          decoration: BoxDecoration(
            color: const Color.fromRGBO(246, 246, 246, 1),
            borderRadius: BorderRadius.circular(ScreenAdapter.height(96 / 2)),
          ),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(
                    ScreenAdapter.width(34), 0, ScreenAdapter.width(10), 0),
                child: const Icon(Icons.search),
              ),
              Text("手机",
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: ScreenAdapter.fontSize(32)))
            ],
          ),
        ),
        onTap: () {
          Get.toNamed(Routes.SEARCH);
        },
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Row(
        children: [
          SizedBox(
            width: ScreenAdapter.width(280),
            height: double.infinity,
            child: Obx(
              () {
                return ListView.builder(
                  itemCount: controller.leftList.length,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      width: double.infinity,
                      height: ScreenAdapter.height(180),
                      child: Obx(() {
                        return InkWell(
                          onTap: () {
                            controller.changeIndex(index);
                          },
                          child: Row(
                            children: [
                              Container(
                                width: ScreenAdapter.width(10),
                                height: ScreenAdapter.height(46),
                                color: controller.selecetIndex.value == index
                                    ? Colors.red
                                    : Colors.white,
                              ),
                              SizedBox(
                                width: ScreenAdapter.width(40),
                              ),
                              Text('${controller.leftList[index].title}'),
                            ],
                          ),
                        );
                      }),
                    );
                  },
                );
              },
            ),
          ),
          Expanded(
            child: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Obx(() {
                return GridView.builder(
                  itemCount: controller.rightList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: ScreenAdapter.width(40),
                      mainAxisSpacing: ScreenAdapter.height(20),
                      childAspectRatio: 240 / 340),
                  itemBuilder: (context, index) {
                    return InkWell(
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            width: double.infinity,
                            child: Image.network(
                              HttpsClient.replaeUri(controller.rightList[index].pic),
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(
                                0, ScreenAdapter.height(10), 0, 0),
                            child: Text("${controller.rightList[index].title}",
                                style: TextStyle(
                                    fontSize: ScreenAdapter.fontSize(34))),
                          )
                        ],
                      ),
                      onTap: (){
                        Get.toNamed('/product-list', arguments: {'cid': controller.rightList[index].sId});
                      },
                    );
                  },
                );
              }),
            ),
          )
        ],
      ),
    ));
  }
}
