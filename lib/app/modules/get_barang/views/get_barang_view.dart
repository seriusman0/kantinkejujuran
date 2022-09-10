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
                            ]),
                          ));
                      // Text( "$index Nama Produk = ${controller.namaBarang[index]}"),);
                    },
                  ),
          )),
        ],
      ),
    );
  }
}
