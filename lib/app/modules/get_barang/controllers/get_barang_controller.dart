import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:developer' as developer;
import 'package:http/http.dart' as http;

import '../../../../globals.dart';
import '../../../routes/app_pages.dart';

class GetBarangController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<String> id_barang = [''].obs;
  RxList<String> nama_barang = ['loading data, silakan tunggu'].obs;
  RxList<int> harga_barang = [0].obs;
  final server = Global.server;

  Future deleteBarang(var id) async {
    try {
      return await http.post(
        Uri.parse("$server/del_barang.php"),
        body: {"id_barang": id},
      ).then((value) {
        if (value.body.isNotEmpty) {
          var data = json.decode(value.body);
          Get.snackbar("Result", data["message"]);
          Get.offAllNamed(Routes.GET_BARANG);
        }
      });
    } catch (e) {
      print(e);
      Get.snackbar("Result", e.toString());
      Get.offAllNamed(Routes.GET_BARANG);
    }
  }

  Future<RxList<String>> getBarang() async {
    try {
      final response = await http.get(Uri.parse("$server/get_barang.php"));
      if (response.statusCode == 200) {
        this.id_barang.removeRange(0, this.id_barang.length);
        this.nama_barang.removeRange(0, this.nama_barang.length);
        this.harga_barang.removeRange(0, this.harga_barang.length);
        for (int i = 0; i < (json.decode(response.body).length); i++) {
          this.id_barang.add(jsonDecode(response.body)[i]['id_barang']);
          this.nama_barang.add(jsonDecode(response.body)[i]['nama_barang']);
          this
              .harga_barang
              .add(int.parse(jsonDecode(response.body)[i]['harga_barang']));
        }
      }
    } catch (e) {
      print("Error $e");
    }
    return this.id_barang;
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getBarang();
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
