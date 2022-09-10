import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

class Global {
  static const String server = 'http://192.168.43.45/kantinkejujuran/api';
  // static const String server =
  //     'https://haziest-acres.000webhostapp.com/kantinkejujuran/api';

  static Future<void> setSession(
      bool status,
      String id_user,
      String nama_user,
      String nohp_user,
      String username,
      String password,
      String otoritas) async {
    await SessionManager().set("isLogin", true);
    await SessionManager().set("id_user", id_user);
    await SessionManager().set("nama_user", nama_user);
    await SessionManager().set("nohp_user", nohp_user);
    await SessionManager().set("username", username);
    await SessionManager().set("password", password);
    await SessionManager().set("otoritas", otoritas);
  }

  static Future<void> destroySession() async {
    await SessionManager().set("isLogin", false);
    await SessionManager().set("id", "");
    await SessionManager().set("nama", "");
    await SessionManager().set("username", "");
    await SessionManager().set("password", "");
    await SessionManager().set("otoritas", "");
    Get.offAllNamed(Routes.LOGIN);
  }

  static cekLogin() async {
    var result = await SessionManager().get("isLogin");
    print(result);
    if (result == false) Get.offAllNamed(Routes.LOGIN);
  }

  static cekPrivilege() async {
    var response = await SessionManager().get("otoritas");
    var registrasi = await (response.contains('registrasi')) ? true : false;
    var inspeksi = await (response.contains('inspeksi')) ? true : false;
    var cetakqr = await (response.contains('cetakqr')) ? true : false;
    var view = await (response.contains('view')) ? true : false;
    var pengaturan = await (response.contains('pengaturan')) ? true : false;
    var otorisasiuser =
        await (response.contains('otorisasiuser')) ? true : false;

    return [registrasi, inspeksi, cetakqr, view, pengaturan, otorisasiuser];
  }
}
