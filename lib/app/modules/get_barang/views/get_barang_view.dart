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
        actions: [
          IconButton(
              onPressed: () {
                Get.toNamed(Routes.ADD_BARANG);
              },
              icon: Icon(Icons.add))
        ],
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
                    itemCount: controller.id_barang.length,
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
                                      Text(
                                        "${controller.nama_barang[index]}",
                                        style: TextStyle(fontSize: 15),
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
                                                  .harga_barang[index])),
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
                                          onPressed: () {
                                            Get.offAllNamed(Routes.EDIT_BARANG,
                                                arguments: [
                                                  controller.id_barang[index],
                                                  controller.nama_barang[index],
                                                  controller.harga_barang[index]
                                                ]);
                                          },
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
                                                  "Anda yakin akan tindakan ini? ${controller.id_barang[index]}",
                                              textConfirm: "Ya",
                                              confirmTextColor: Colors.white,
                                              onCancel: () => Get.back(),
                                              onConfirm: () {
                                                controller.deleteBarang(
                                                    controller
                                                        .id_barang[index]);
                                              },
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
