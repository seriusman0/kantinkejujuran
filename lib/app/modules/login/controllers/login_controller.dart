import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../../globals.dart';
import '../../../routes/app_pages.dart';

class LoginController extends GetxController {
  RxBool isLoading = false.obs;
  var server = Global.server;
  TextEditingController usernameC = TextEditingController(text: "nomar");
  TextEditingController passwordC = TextEditingController(text: "nomars");

  Future<dynamic> login() async {
    if (usernameC.text.isNotEmpty && passwordC.text.isNotEmpty) {
      try {
        return await http.post(
          Uri.parse("$server/login.php"),
          body: {
            "username": this.usernameC.text.toString(),
            "password": this.passwordC.text.toString()
          },
        ).then((value) async {
          if (value.body.isNotEmpty) {
            var response = jsonDecode(value.body.toString());

            await Global.setSession(
                true,
                response["body"][0]["id_user"],
                response["body"][0]["nama_user"],
                response["body"][0]["nohp_user"],
                response["body"][0]["username"],
                response["body"][0]["password"],
                response["body"][0]["otoritas"].toString());

            Get.offAllNamed(Routes.HOME_ADMIN);
          }
        });
      } catch (e) {
        print(e);
      }
    } else {
      isLoading.value = false;
      // Get.snackbar("Terjadi kesalahan", "Username dan Password wajib diisi");
      isLoading.value = false;
    }
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
