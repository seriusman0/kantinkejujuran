import 'dart:convert';
import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../../globals.dart';

class AddCartController extends GetxController {
  RxBool isLoading = true.obs;
  final server = Global.server;
  String scannedQrcode = '';
  RxList<String> qrCode = [''].obs;
  RxList<String> namaBarang = ['loading data, silakan tunggu'].obs;
  RxList<int> jumlah = [0].obs;
  RxList<int> harga = [0].obs;
  RxList<int> totalC = [0].obs;
  List<int> idCart = [0];

  Future<void> addCart(String scannedQrcode) async {
    try {
      return await http.post(
        Uri.parse("$server/add_cart.php"),
        body: {'id': scannedQrcode},
      ).then((value) {
        Get.snackbar("Nilai yang dikirim ", "$scannedQrcode");
        if (value.body.isNotEmpty) {
          this.getCartProduct();
        }
      });
    } catch (e) {
      Get.snackbar("Gagal", "$e");
      print(e);
    }
  }

  Future<void> scanQR() async {
    try {
      scannedQrcode = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666",
        'Cancel',
        true,
        ScanMode.BARCODE,
      );
      if (scannedQrcode != "-1") {
        addCart(scannedQrcode);
        Get.snackbar(
          "Result",
          "QR Code " + scannedQrcode,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      }
    } on PlatformException {
    } catch (e) {}
  }

  Future<RxList<String>> getCartProduct() async {
    try {
      final response = await http.get(Uri.parse("$server/get_cart.php"));
      if (response.statusCode == 200) {
        this.qrCode.removeRange(0, this.qrCode.length);
        this.namaBarang.removeRange(0, this.namaBarang.length);
        this.jumlah.removeRange(0, this.jumlah.length);
        this.harga.removeRange(0, this.harga.length);
        this.totalC.removeRange(0, this.totalC.length);
        this.idCart.removeRange(0, this.idCart.length);
        for (int i = 0; i < (json.decode(response.body).length); i++) {
          this.qrCode.add(jsonDecode(response.body)[i]['id_barang']);
          this.namaBarang.add(jsonDecode(response.body)[i]['nama_barang']);
          this.jumlah.add(int.parse(jsonDecode(response.body)[i]['jumlah']));
          this
              .harga
              .add(int.parse(jsonDecode(response.body)[i]['harga_barang']));
          this.totalC.add(int.parse(jsonDecode(response.body)[i]['total']));
          this.idCart.add(int.parse(jsonDecode(response.body)[i]['id_cart']));
        }
        developer.log(qrCode.toString());
      }
    } catch (e) {
      print("Error $e");
    }
    return this.qrCode;
  }

  Future<void> updateCart() async {
    try {
      return await http.post(
        Uri.parse("$server/update_cart.php"),
        body: {
          'idCart': this.idCart.toString(),
          'jumlah': this.jumlah.toString()
        },
      ).then((value) {
        if (value.body.isNotEmpty) {
          this.getCartProduct();
        }
      });
    } catch (e) {
      Get.snackbar("Gagal", "$e");
      print(e);
    }
  }

  final count = 0.obs;
  @override
  onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getCartProduct();
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
