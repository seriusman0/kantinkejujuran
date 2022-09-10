import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../routes/app_pages.dart';
import '../controllers/get_barang_controller.dart';

class GetBarangView extends GetView<GetBarangController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Barang'),
        centerTitle: true,
        leading: BackButton(
          onPressed: () => Get.offAllNamed(Routes.HOME_ADMIN),
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
                    itemCount: controller.id_barang.length,
                    itemBuilder: (context, index) {
                      return Container(
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(64, 75, 96, .9)),
                          child: Card(
                            child: Row(children: [
                              Expanded(
                                child: ListTile(
                                  title:
                                      Text("${controller.nama_barang[index]}"),
                                  subtitle:
                                      Text("${controller.harga_barang[index]}"),
                                ),
                              ),
                              Expanded(
                                child: Center(
                                    child: Obx((() => Text(
                                        textAlign: TextAlign.right,
                                        NumberFormat.currency(
                                                locale: 'id',
                                                decimalDigits: 0,
                                                symbol: "Rp ")
                                            .format(controller
                                                    .harga_barang[index] *
                                                controller
                                                    .harga_barang[index]))))),
                              ),
                              // Expanded(
                              //   child: Row(children: [
                              //     Expanded(
                              //       child: ElevatedButton(
                              //           onPressed: () {
                              //             (controller.jumlah[index] > 0)
                              //                 ? controller.jumlah[index] -= 1
                              //                 : 0;
                              //             controller.totalC[index] =
                              //                 controller.jumlah[index] *
                              //                     controller.harga[index];
                              //           },
                              //           child: Text("-")),
                              //     ),
                              //     Expanded(
                              //       child: Center(
                              //           child: Obx((() => Text(controller
                              //               .jumlah[index]
                              //               .toString())))),
                              //     ),
                              //     Expanded(
                              //       child: ElevatedButton(
                              //           onPressed: () {
                              //             controller.jumlah[index] += 1;
                              //             controller.totalC[index] =
                              //                 controller.jumlah[index] *
                              //                     controller.harga[index];
                              //           },
                              //           child: Text("+")),
                              //     )
                              //   ]),
                              // )
                            ]),
                          ));
                      // Text( "$index Nama Produk = ${controller.namaBarang[index]}"),);
                    },
                  ),
          )),
          // ElevatedButton(
          //   child: Text("Bayar"),
          //   onPressed: () {
          //     if (controller.idCart.length > 0 &&
          //         controller.isLoading.isFalse) {
          //       controller.updateCart();
          //       Get.offAllNamed(Routes.CHECK_OUT);
          //     }
          //   },
          // ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: ElevatedButton(
          //           child: Icon(Icons.sync),
          //           onPressed: () async {
          //             // if (controller.isLoading.isFalse) {}
          //             await controller.updateCart();
          //           }),
          //     ),
          //     Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: ElevatedButton(
          //           child: Icon(Icons.add),
          //           onPressed: () {
          //             controller.scanQR();
          //             controller.getCartProduct();
          //           }),
          //     ),
          //     Expanded(
          //       child: Column(
          //         mainAxisAlignment: MainAxisAlignment.start,
          //         children: [
          //           Text("Total"),
          //           Padding(
          //             padding: const EdgeInsets.all(8),
          //             child: Container(
          //                 child: Obx(
          //               () => Text(
          //                   style: TextStyle(fontSize: 30),
          //                   textAlign: TextAlign.right,
          //                   NumberFormat.currency(
          //                           locale: 'id',
          //                           decimalDigits: 0,
          //                           symbol: "Rp ")
          //                       .format(controller.totalC.sum)),
          //             )),
          //           ),
          //         ],
          //       ),
          //     )
          //   ],
          // ),
        ],
      ),
    );
  }
}
