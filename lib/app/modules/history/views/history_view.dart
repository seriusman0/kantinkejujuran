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
        leading: BackButton(
          onPressed: () => Get.offAllNamed(Routes.HOME),
        ),
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
                                  flex: 1,
                                  child: Center(
                                      child: Text(
                                    (index + 1).toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ))),
                              Expanded(
                                flex: 10,
                                child: Container(
                                  margin: EdgeInsets.all(8.0),
                                  padding: EdgeInsets.only(left: 8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${controller.pembeli[index]}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                        textAlign: TextAlign.right,
                                      ),
                                      Text(
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                          textAlign: TextAlign.right,
                                          NumberFormat.currency(
                                                  locale: 'id',
                                                  decimalDigits: 0,
                                                  symbol: "Rp ")
                                              .format(controller
                                                  .total_tagihan[index])),
                                      Text(
                                          style: TextStyle(fontSize: 15),
                                          NumberFormat.currency(
                                                  locale: 'id',
                                                  decimalDigits: 0,
                                                  symbol: "Bayar : Rp ")
                                              .format(controller
                                                  .total_bayar[index])),
                                      Text(
                                          style: TextStyle(fontSize: 15),
                                          NumberFormat.currency(
                                                  locale: 'id',
                                                  decimalDigits: 0,
                                                  symbol: "Kembali : Rp ")
                                              .format(controller
                                                      .total_bayar[index] -
                                                  controller
                                                      .total_tagihan[index])),
                                      Text("${controller.update_at[index]}")
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                  flex: 4,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      ElevatedButton(
                                          onPressed: () {
                                            controller.getPdf(
                                                index,
                                                controller
                                                    .total_tagihan[index]);
                                          },
                                          child: Icon(
                                            Icons.download,
                                          )),
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
