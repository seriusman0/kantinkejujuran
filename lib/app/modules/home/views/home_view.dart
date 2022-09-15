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
        backgroundColor: Colors.grey,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: CircleAvatar(
                  radius: 45,
                  child: ClipOval(
                    child: Image.asset(
                      "assets/images/icon.png",
                      fit: BoxFit.cover,
                      width: 80,
                      height: 80,
                    ),
                  ),
                ),
              ),
              Center(
                child: Text(
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                    "SELAMAT DATANG \nDI APLIKASI \nKANTIN KEJUJURAN \nBROSIS HOUSE KETINTANG"),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shadowColor: MaterialStateProperty.all(Colors.orange),
                      ),
                      onPressed: () {
                        Get.toNamed(Routes.ADD_CART);
                      },
                      child: Text(
                        'Transaksi',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Get.offAllNamed(Routes.HISTORY);
                      },
                      child: Text(
                        'Data Transaksi',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                flex: 2,
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
