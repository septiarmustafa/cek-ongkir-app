import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../data/models/ongkir_model.dart';

class HomeController extends GetxController {
  List<Ongkir> ongkosKirim = [];
  TextEditingController weightC = TextEditingController();

  RxBool isLoading = false.obs;

  RxString provAsalId = "".obs;
  RxString provTujuanId = "".obs;
  RxString cityAsalId = "".obs;
  RxString cityTujuanId = "".obs;
  RxString codeEkspedisi = "".obs;

  void cekOngkir() async {
    if (provAsalId != "0" &&
        provTujuanId != "0" &&
        cityAsalId != "0" &&
        cityTujuanId != "0" &&
        codeEkspedisi != "0" &&
        weightC.text != "0") {
      try {
        isLoading.value = true;
        var response = await http.post(
          Uri.parse("https://api.rajaongkir.com/starter/cost"),
          body: {
            "origin": cityAsalId.value,
            "destination": cityTujuanId.value,
            "weight": weightC.text,
            "courier": codeEkspedisi.value,
          },
          headers: {
            "key": "bfb1c85fc202eff94c738f691617bc5c",
            "content-type": "application/x-www-form-urlencoded"
          },
        );
        isLoading.value = false;
        List ongkir =
            json.decode(response.body)["rajaongkir"]["results"][0]["costs"];
        ongkosKirim = Ongkir.fromJsonList(ongkir);

        Get.defaultDialog(
          title: "Ongkos Kirim",
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: ongkosKirim
                .map(
                  (e) => ListTile(
                    title: Text("${e.service!.toUpperCase()}"),
                    subtitle: Text("${e.cost![0].value}"),
                  ),
                )
                .toList(),
          ),
        );
      } catch (e) {
        Get.defaultDialog(
            title: "Terjadi Kesalahan",
            middleText: "Tidak dapat mengecek ongkir");
      }
    } else {
      Get.defaultDialog(
          title: "Terjadi Kesalahan", middleText: "Data Input Belum Lengkap");
    }
  }
}
