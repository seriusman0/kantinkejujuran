class Barang {
  String? idBarang;
  String? namaBarang;
  String? hargaBarang;
  String? stokBarang;
  String? createdAt;

  Barang(
      {this.idBarang,
      this.namaBarang,
      this.hargaBarang,
      this.stokBarang,
      this.createdAt});

  Barang.fromJson(Map<String, dynamic> json) {
    idBarang = json['id_barang'];
    namaBarang = json['nama_barang'];
    hargaBarang = json['harga_barang'];
    stokBarang = json['stok_barang'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id_barang'] = idBarang;
    data['nama_barang'] = namaBarang;
    data['harga_barang'] = hargaBarang;
    data['stok_barang'] = stokBarang;
    data['created_at'] = createdAt;
    return data;
  }
}
