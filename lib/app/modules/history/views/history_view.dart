import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../routes/app_pages.dart';
import '../controllers/history_controller.dart';

class HistoryView extends GetView<HistoryController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HistoryView'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
              child: Obx(
            () => (controller.isLoading.isTrue)
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: controller.id_payment.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Card(
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Container(
                                  padding: EdgeInsets.only(left: 8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("${controller.pembeli[index]}"),
                                      Text(
                                          style: TextStyle(fontSize: 15),
                                          NumberFormat.currency(
                                                  locale: 'id',
                                                  decimalDigits: 0,
                                                  symbol: "Total bayar : Rp ")
                                              .format(controller
                                                  .total_bayar[index])),
                                      Text(
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                          textAlign: TextAlign.right,
                                          NumberFormat.currency(
                                                  locale: 'id',
                                                  decimalDigits: 0,
                                                  symbol: "Total Bayar : Rp ")
                                              .format(
                                                  controller.total_tagihan[0])),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                  flex: 1,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      ElevatedButton(
                                          onPressed: () {},
                                          child: Icon(
                                            Icons.edit,
                                            color: Colors.green,
                                          )),
                                      ElevatedButton(
                                          onPressed: () {
                                            Get.defaultDialog(
                                              textCancel: "Batal",
                                              title: "Hapus Akun",
                                              middleText:
                                                  "Anda yakin akan tindakan ini? ${controller.id_payment[index]}",
                                              textConfirm: "Ya",
                                              confirmTextColor: Colors.white,
                                              onCancel: () => Get.back(),
                                              onConfirm: () {},
                                            );
                                          },
                                          child: Icon(Icons.delete,
                                              color: Colors.red)),
                                    ],
                                  ))
                            ],
                          ),
                        ),
                      );
                    }),
          )),
        ],
      ),
    );
  }
}
