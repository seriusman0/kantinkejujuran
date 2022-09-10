import 'package:get/get.dart';

import '../modules/add_barang/bindings/add_barang_binding.dart';
import '../modules/add_barang/views/add_barang_view.dart';
import '../modules/add_cart/bindings/add_cart_binding.dart';
import '../modules/add_cart/views/add_cart_view.dart';
import '../modules/check_out/bindings/check_out_binding.dart';
import '../modules/check_out/views/check_out_view.dart';
import '../modules/edit_barang/bindings/edit_barang_binding.dart';
import '../modules/edit_barang/views/edit_barang_view.dart';
import '../modules/get_barang/bindings/get_barang_binding.dart';
import '../modules/get_barang/views/get_barang_view.dart';
import '../modules/history/bindings/history_binding.dart';
import '../modules/history/views/history_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/home_admin/bindings/home_admin_binding.dart';
import '../modules/home_admin/views/home_admin_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.ADD_CART,
      page: () => AddCartView(),
      binding: AddCartBinding(),
    ),
    GetPage(
      name: _Paths.CHECK_OUT,
      page: () => CheckOutView(),
      binding: CheckOutBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.HOME_ADMIN,
      page: () => HomeAdminView(),
      binding: HomeAdminBinding(),
    ),
    GetPage(
      name: _Paths.ADD_BARANG,
      page: () => AddBarangView(),
      binding: AddBarangBinding(),
    ),
    GetPage(
      name: _Paths.GET_BARANG,
      page: () => GetBarangView(),
      binding: GetBarangBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_BARANG,
      page: () => EditBarangView(),
      binding: EditBarangBinding(),
    ),
    GetPage(
      name: _Paths.HISTORY,
      page: () => HistoryView(),
      binding: HistoryBinding(),
    ),
  ];
}
