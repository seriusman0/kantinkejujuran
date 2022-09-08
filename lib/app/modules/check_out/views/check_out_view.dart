import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../routes/app_pages.dart';
import '../controllers/check_out_controller.dart';

class CheckOutView extends GetView<CheckOutController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pembayaran'),
        centerTitle: true,
        leading: BackButton(
          onPressed: () => Get.offAllNamed(Routes.ADD_CART),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Total Tagihan"),
            Padding(
                padding: const EdgeInsets.all(8),
                child: Container(
                    child: Obx((() => Text(
                        style: TextStyle(fontSize: 30),
                        textAlign: TextAlign.right,
                        NumberFormat.currency(
                                locale: 'id', decimalDigits: 0, symbol: "Rp ")
                            .format(controller.totalC.value)))))),
            Container(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Center(
                  child: Text(
                    "Bayar",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: TextField(
                  controller: controller.bayarC.value,
                  autofocus: true,
                  textAlign: TextAlign.center,
                  inputFormatters: [
                    CurrencyTextInputFormatter(
                        locale: 'id', decimalDigits: 0, symbol: '')
                  ],
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  onChanged: (value) {
                    // controller.kembaliC.value = int.parse(
                    //     (controller.bayarC.value.text != 0)
                    //         ? controller.bayarC.value.text
                    //             .replaceAll(new RegExp(r'[^0-9]'), '')
                    //         : 0.toString());
                  }),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Center(
                  child: Text(
                    "Pembeli",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: TextField(
                  controller: controller.pembeliC.value,
                  autofocus: true,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  onChanged: (value) {}),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  if (controller.isLoading.value == false &&
                      controller.bayarC.value != '' &&
                      controller.pembeliC.value != '')
                    controller.payOut();
                  else
                    Get.snackbar("Ada Kesalahan",
                        "Mohon pastikan semua field sudah terisi");
                },
                child: Text("Bayar")),
          ],
        ),
      ),
    );
  }
}
