import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import '../../../../globals.dart';

class EditBarangController extends GetxController {
  var server = Global.server;
  TextEditingController id_barang =
      TextEditingController(text: Get.arguments[0]);
  TextEditingController nama_barang =
      TextEditingController(text: Get.arguments[1]);
  TextEditingController harga_barang =
      TextEditingController(text: Get.arguments[2].toString());

  Future updateBarang() async {
    try {
      if (id_barang.text == '' &&
          nama_barang.text == '' &&
          harga_barang.text == '') {
        Get.snackbar("Error", "Semua field wajib diisi");
        throw new FormatException();
      }
      return await http.post(
        Uri.parse("$server/edit_barang.php"),
        body: {
          "id_barang": id_barang.value.text,
          "harga_barang": harga_barang.value.text,
          "nama_barang": nama_barang.value.text
        },
      ).then((value) {
        if (value.body.isNotEmpty) {
          Get.snackbar("Berhasil", "Data berhasil disimpan",
              snackPosition: SnackPosition.BOTTOM);
        }
      });
    } catch (e) {
      print(e);
      Get.snackbar("Gagal", "Data tidak tersimpan",
          snackPosition: SnackPosition.BOTTOM);
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
