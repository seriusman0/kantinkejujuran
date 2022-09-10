import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';

import '../../../../globals.dart';
import '../../../routes/app_pages.dart';

class AddBarangController extends GetxController {
  TextEditingController id_barang = TextEditingController();
  TextEditingController nama_barang = TextEditingController();
  TextEditingController harga_barang = TextEditingController();
  final server = Global.server;
  var scannedQrcode = ''.obs;

  Future<void> scanQR() async {
    try {
      scannedQrcode.value = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666",
        'Cancel',
        true,
        ScanMode.BARCODE,
      );
      if (scannedQrcode.value != "-1") {
        id_barang.text = scannedQrcode.value;
        Get.snackbar(
          "Result",
          "QR Code " + scannedQrcode.value,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      }
    } on PlatformException {
    } catch (e) {}
  }

  Future submit() async {
    try {
      if (id_barang.text == '' &&
          nama_barang.text == '' &&
          harga_barang.text == '') {
        Get.snackbar("Error", "Semua field wajib diisi");
        throw new FormatException();
      }
      return await http.post(
        Uri.parse("$server/add_barang.php"),
        body: {
          "id_barang": id_barang.value.text,
          "harga_barang": harga_barang.value.text,
          "nama_barang": nama_barang.value.text
        },
      ).then((value) {
        if (value.body.isNotEmpty) {
          var data = json.decode(value.body);
          Get.snackbar("Berhasil", "$data");
        }
      });
    } catch (e) {
      print(e);
      Get.snackbar("Gagal", "Input Barang Gagal");
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
