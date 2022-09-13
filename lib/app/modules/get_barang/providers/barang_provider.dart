import 'package:get/get.dart';

import '../barang_model.dart';

class BarangProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return Barang.fromJson(map);
      if (map is List) return map.map((item) => Barang.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<Barang?> getBarang(int id) async {
    final response = await get('barang/$id');
    return response.body;
  }

  Future<Response<Barang>> postBarang(Barang barang) async =>
      await post('barang', barang);
  Future<Response> deleteBarang(int id) async => await delete('barang/$id');
}
