import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('LOGIN'),
        centerTitle: true,
        leading: BackButton(
          onPressed: () => Get.offAllNamed(Routes.HOME),
        ),
      ),
      body: Column(
        children: [
          Expanded(
              flex: 1,
              child: Container(
                child: Center(
                    child: Text(
                  textAlign: TextAlign.center,
                  "SISTEM KASIR KANTIN KEJUJURAN",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                )),
              )),
          Expanded(
              flex: 5,
              child: Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Username",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                        textAlign: TextAlign.start,
                      ),
                      TextField(
                        controller: controller.usernameC,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                          prefixIcon: Icon(Icons.account_circle),
                          // labelText: 'username',
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Password",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      TextField(
                        controller: controller.passwordC,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          prefixIcon: Icon(Icons.lock),
                          // labelText: 'password',
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(),
                          ),
                          Expanded(
                            child: Container(
                                child: Obx(
                              () => ElevatedButton(
                                  child: Text(controller.isLoading.isFalse
                                      ? "Sign In"
                                      : "LOADING  . . ."),
                                  onPressed: () {
                                    controller.login();
                                  }),
                            )),
                          ),
                        ],
                      )
                    ],
                  ))),
        ],
      ),
    );
  }
}
