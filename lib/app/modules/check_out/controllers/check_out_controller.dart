import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../../globals.dart';
import '../../../routes/app_pages.dart';

class CheckOutController extends GetxController {
  RxBool isLoading = true.obs;
  final server = Global.server;
  var totalC = 0.obs;

  Rx<TextEditingController> bayarC = TextEditingController().obs;
  Rx<TextEditingController> pembeliC = TextEditingController().obs;
  var kembaliC = 0.obs;

  final count = 0.obs;
  @override
  Future<void> onInit() async {
    await getTotal();
    if (this.totalC.value == 0) Get.offAllNamed(Routes.ADD_CART);
    super.onInit();
  }

  Future<void> getTotal() async {
    try {
      final response = await http.get(Uri.parse("$server/get_total.php"));
      if (response.statusCode == 200) {
        this.totalC.value = int.parse(jsonDecode(response.body)[0]['total']);
        isLoading.value = false;
      }
    } catch (e) {
      print("Error $e");
      isLoading.value = false;
    }
  }

  Future payOut() async {
    try {
      return await http.post(
        Uri.parse("$server/payment.php"),
        body: {"bayar": bayarC.value.text, "pembeli": pembeliC.value.text},
      ).then((value) {
        if (value.body.isNotEmpty) {
          var data = json.decode(value.body);
          // print(data["message"]);
          Get.snackbar("Berhasil", "$data");
        }
        Get.snackbar("Berhasil", "Transaksi terakhir anda berhasil");
        Get.offAllNamed(Routes.ADD_CART);
      });
    } catch (e) {
      // print(e);
      // Get.snackbar("Transaksi Gagal", "Mohon ulangi");
      if (this.totalC.value == 0) {
        Get.offAllNamed(Routes.ADD_CART);
      } else
        Get.offAllNamed(Routes.CHECK_OUT);
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
