import 'dart:convert';
import 'package:open_file/open_file.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:developer' as developer;
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../../../globals.dart';

class HistoryController extends GetxController {
  RxBool isLoading = true.obs;
  var id_payment = [''].obs;
  var pembeli = [''].obs;
  var total_bayar = [0].obs;
  var update_at = [''].obs;
  var total_tagihan = [0].obs;
  final server = Global.server;

  //item History
  var item_id_barang = [''].obs;
  var item_nama_barang = [''].obs;
  var item_jumlah = [0].obs;
  var item_harga_barang = [0].obs;
  var item_total = [0].obs;

  Future<RxList<String>> getItemHistory(var id_payment) async {
    try {
      final response = await http.get(
          Uri.parse("$server/get_item_history.php?id_payment=$id_payment"));
      if (response.statusCode == 200) {
        this.item_id_barang.removeRange(0, this.item_id_barang.length);
        this.item_nama_barang.removeRange(0, this.item_nama_barang.length);
        this.item_jumlah.removeRange(0, this.item_jumlah.length);
        this.item_harga_barang.removeRange(0, this.item_harga_barang.length);
        this.item_total.removeRange(0, this.item_total.length);

        for (int i = 0; i < (json.decode(response.body).length); i++) {
          this
              .item_id_barang
              .add(jsonDecode(response.body)['body'][i]['id_barang']);
          this
              .item_nama_barang
              .add(jsonDecode(response.body)['body'][i]['nama_barang']);
          this
              .item_jumlah
              .add(int.parse(jsonDecode(response.body)['body'][i]['jumlah']));
          this.item_harga_barang.add(
              int.parse(jsonDecode(response.body)['body'][i]['harga_barang']));
          this
              .item_total
              .add(int.parse(jsonDecode(response.body)['body'][i]['total']));
        }
      }
    } catch (e) {
      print("Error $e");
    }
    return this.id_payment;
  }

  Future<RxList<String>> getHistory() async {
    try {
      final response = await http.get(Uri.parse("$server/get_history.php"));
      if (response.statusCode == 200) {
        this.id_payment.removeRange(0, this.id_payment.length);
        this.pembeli.removeRange(0, this.pembeli.length);
        this.total_bayar.removeRange(0, this.total_bayar.length);
        this.update_at.removeRange(0, this.update_at.length);

        for (int i = 0; i < (json.decode(response.body).length); i++) {
          this.id_payment.add(jsonDecode(response.body)[i]['id_payment']);
          this.pembeli.add(jsonDecode(response.body)[i]['pembeli']);
          this
              .total_bayar
              .add(int.parse(jsonDecode(response.body)[i]['total_bayar']));
          this
              .update_at
              .add(getFormattedDate(jsonDecode(response.body)[i]['update_at']));
        }
      }
    } catch (e) {
      print("Error $e");
    }
    return this.id_payment;
  }

  String getFormattedDate(String date) {
    /// Convert into local date format.
    var localDate = DateTime.parse(date).toLocal();

    /// inputFormat - format getting from api or other func.
    /// e.g If 2021-05-27 9:34:12.781341 then format should be yyyy-MM-dd HH:mm
    /// If 27/05/2021 9:34:12.781341 then format should be dd/MM/yyyy HH:mm
    var inputFormat = DateFormat('yyyy-MM-dd HH:mm');
    var inputDate = inputFormat.parse(localDate.toString());

    /// outputFormat - convert into format you want to show.
    var outputFormat = DateFormat('EEE dd/MM/yyyy HH:mm');
    var outputDate = outputFormat.format(inputDate);

    return outputDate.toString();
  }

  Future<RxList<String>> getTotalTagihan() async {
    try {
      this.total_tagihan.removeRange(0, this.total_tagihan.length);
      // Get.snackbar("Oke", "${this.total_bayar.length}");

      for (int i = 0; i < this.total_bayar.length; i++) {
        final response = await http.get(Uri.parse(
            "$server/get_total_tagihan.php?id_payment=${id_payment[i]}"));
        if (response.statusCode == 200) {
          this
              .total_tagihan
              .add(int.parse(jsonDecode(response.body)['total_tagihan']));
        }
      }
    } catch (e) {
      print("Error $e");
    }
    return this.id_payment;
  }

  Future<void> getPdf(var index, var total_tagihan) async {
    await getItemHistory(this.id_payment[index]);
    print(item_nama_barang.toString());
    final pdf = pw.Document();

    // buat page
    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a6,
        build: (pw.Context context) {
          return pw.Expanded(
              child: pw.Center(
                  child: pw.Column(
            children: [
              pw.Text("Struk Belanja"),
              pw.Text("Kantin Kejujuran"),
              pw.Text("Brosis House Ketintang"),
              pw.ListView.builder(
                  itemCount: this.item_id_barang.length,
                  itemBuilder: (context, index) {
                    return pw.Column(
                        mainAxisAlignment: pw.MainAxisAlignment.start,
                        children: [
                          pw.Row(
                              mainAxisAlignment: pw.MainAxisAlignment.start,
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text(
                                    "${(index + 1)}. ${this.item_nama_barang[index]}"),
                                pw.SizedBox(width: 5),
                                pw.Text(
                                    textAlign: pw.TextAlign.right,
                                    NumberFormat.currency(
                                            locale: 'id',
                                            decimalDigits: 0,
                                            symbol: "Rp ")
                                        .format(this.item_harga_barang[index])),
                                pw.Text(" x${this.item_jumlah[index]} "),
                                pw.SizedBox(width: 5),
                                pw.Text(
                                    textAlign: pw.TextAlign.right,
                                    NumberFormat.currency(
                                            locale: 'id',
                                            decimalDigits: 0,
                                            symbol: "Rp ")
                                        .format(this.item_total[index])),
                                pw.SizedBox(width: 5),
                              ]),
                        ]);
                  }),
              pw.SizedBox(height: 30),
              pw.Text("Jumlah :",
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              pw.Text(
                  textAlign: pw.TextAlign.right,
                  NumberFormat.currency(
                          locale: 'id', decimalDigits: 0, symbol: "Rp ")
                      .format(total_tagihan)),
            ],
          ))); // Center
        })); // Page}

    // simpan page
    final bytes = await pdf.save();

    // buat file kosong di directory
    final dir = await getApplicationDocumentsDirectory();
    final file = File("${dir.path}/AsetQrGenerate.pdf");

    // timpa file yang tadi koso dengan file baru
    await file.writeAsBytes(bytes);

    // open pdf
    await OpenFile.open(file.path);
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getHistory();
      await getTotalTagihan();
      this.isLoading.value = await false;
      developer.log("Loading data selesai");
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
