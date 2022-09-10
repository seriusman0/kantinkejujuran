import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../globals.dart';
import '../../../routes/app_pages.dart';
import '../controllers/home_admin_controller.dart';

class HomeAdminView extends GetView<HomeAdminController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Admin'),
        centerTitle: true,
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () => Get.offAllNamed(Routes.ADD_BARANG),
              child: Text("Tambah Barang")),
          ElevatedButton(
              onPressed: () => Get.offAllNamed(Routes.GET_BARANG),
              child: Text("Daftar Barang")),
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Global.destroySession();
        },
        child: Icon(Icons.logout),
      ),
    );
  }
}
