import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage("assets/images/background.jpg"),
        fit: BoxFit.cover,
      )),
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Center(child: Text("")),
              ),
              ElevatedButton(
                onPressed: () {
                  Get.toNamed(Routes.ADD_CART);
                  // controller.scanQR();
                },
                child: Text(
                  'Transaksi',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Expanded(
                child: Container(),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.offAllNamed(Routes.LOGIN);
          },
          child: Icon(Icons.login),
        ),
      ),
    );
  }
}
