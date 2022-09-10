import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:developer' as developer;
import 'package:http/http.dart' as http;

import '../../../../globals.dart';

class HistoryController extends GetxController {
  RxBool isLoading = true.obs;
  var id_payment = [''].obs;
  var pembeli = [''].obs;
  var total_bayar = [0].obs;
  var update_at = [''].obs;
  var total_tagihan = [0].obs;
  final server = Global.server;

  Future<RxList<String>> getHistory() async {
    try {
      final response = await http.get(Uri.parse("$server/get_history.php"));
      if (response.statusCode == 200) {
        this.id_payment.removeRange(0, this.id_payment.length);
        this.pembeli.removeRange(0, this.pembeli.length);
        this.total_bayar.removeRange(0, this.total_bayar.length);
        this.update_at.removeRange(0, this.update_at.length);
        Get.snackbar("Oke", "Okeee");

        for (int i = 0; i < (json.decode(response.body).length); i++) {
          this.id_payment.add(jsonDecode(response.body)[i]['id_payment']);
          this.pembeli.add(jsonDecode(response.body)[i]['pembeli']);
          this
              .total_bayar
              .add(int.parse(jsonDecode(response.body)[i]['total_bayar']));
          this.update_at.add(jsonDecode(response.body)[i]['update_at']);
          this.pembeli.add(jsonDecode(response.body)[i]['pembeli']);
        }
      }
    } catch (e) {
      print("Error $e");
    }
    return this.id_payment;
  }

  Future<RxList<String>> getTotalTagihan() async {
    try {
      final response = await http.get(Uri.parse("$server/get_total_bayar.php"));
      if (response.statusCode == 200) {
        this.total_tagihan.removeRange(0, this.total_tagihan.length);
        Get.snackbar("Oke", "Okeee");

        for (int i = 0; i < total_bayar.length; i++) {
          this
              .total_bayar
              .add(int.parse(jsonDecode(response.body)[i]['total_bayar']));
        }
      }
    } catch (e) {
      print("Error $e");
    }
    return this.id_payment;
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getHistory();
      await getTotalTagihan();
      this.isLoading.value = await false;
      developer.log("Loading data selesai");
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
