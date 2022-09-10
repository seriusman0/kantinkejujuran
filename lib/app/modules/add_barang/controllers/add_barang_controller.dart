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

  Future payOut() async {
    try {
      return await http.post(
        Uri.parse("$server/payment.php"),
        body: {
          "id_barang": id_barang.value.text,
          "harga_barang": harga_barang.value.text,
          "nama_barang": nama_barang.value.text
        },
      ).then((value) {
        if (value.body.isNotEmpty) {
          var data = json.decode(value.body);
          // print(data["message"]);
          Get.snackbar("Berhasil", "$data");
        }
        Get.snackbar("Berhasil", "Input Barang Berhasil");
      });
    } catch (e) {
      print(e);
      Get.snackbar("Gagal", "Input Barang Gagal");
      // if (this.totalC.value == 0) {
      //   Get.offAllNamed(Routes.ADD_CART);
      // } else
      //   Get.offAllNamed(Routes.CHECK_OUT);
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
