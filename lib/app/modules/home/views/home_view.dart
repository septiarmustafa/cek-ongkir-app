import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import 'package:dropdown_search/dropdown_search.dart';
import '../../../data/models/province_model.dart';
import '../../../data/models/city_model.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ONGKOS KIRIM'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          DropdownSearch<Province>(
            popupProps: PopupProps.menu(
              itemBuilder: (context, item, isSelected) => ListTile(
                title: Text(item.province ?? ''),
              ),
              showSearchBox: true,
              searchFieldProps: TextFieldProps(
                autocorrect: false,
              ),
            ),
            asyncItems: (text) async {
              var response = await Dio().get(
                  "https://api.rajaongkir.com/starter/province",
                  queryParameters: {"key": "bfb1c85fc202eff94c738f691617bc5c"});

              return Province.fromJsonList(
                  response.data["rajaongkir"]["results"]);
            },
            dropdownDecoratorProps: const DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                labelText: "Provinsi Asal",
                hintText: "Pilih  Provinsi",
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                border: OutlineInputBorder(),
              ),
            ),
            onChanged: (value) =>
                controller.provAsalId.value = value?.provinceId ?? "",
          ),
          SizedBox(
            height: 10,
          ),
          DropdownSearch<City>(
            popupProps: PopupProps.menu(
              itemBuilder: (context, item, isSelected) => ListTile(
                title: Text("${item.type ?? ''} ${item.cityName ?? ''}"),
              ),
              showSearchBox: true,
              searchFieldProps: TextFieldProps(
                autocorrect: false,
              ),
            ),
            asyncItems: (text) async {
              var response = await Dio().get(
                  "https://api.rajaongkir.com/starter/city?province=${controller.provAsalId}",
                  queryParameters: {"key": "bfb1c85fc202eff94c738f691617bc5c"});

              return City.fromJsonList(response.data["rajaongkir"]["results"]);
            },
            dropdownDecoratorProps: const DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                labelText: "Kota Asal",
                hintText: "Pilih  Kota",
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                border: OutlineInputBorder(),
              ),
            ),
            onChanged: (value) =>
                controller.cityAsalId.value = value?.cityId ?? "",
          ),
          SizedBox(
            height: 20,
          ),
          DropdownSearch<Province>(
            popupProps: PopupProps.menu(
              itemBuilder: (context, item, isSelected) => ListTile(
                title: Text(item.province ?? ''),
              ),
              showSearchBox: true,
              searchFieldProps: TextFieldProps(
                autocorrect: false,
              ),
            ),
            asyncItems: (text) async {
              var response = await Dio().get(
                  "https://api.rajaongkir.com/starter/province",
                  queryParameters: {"key": "bfb1c85fc202eff94c738f691617bc5c"});

              return Province.fromJsonList(
                  response.data["rajaongkir"]["results"]);
            },
            dropdownDecoratorProps: const DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                labelText: "Provinsi Tujuan",
                hintText: "Pilih  Provinsi",
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                border: OutlineInputBorder(),
              ),
            ),
            onChanged: (value) =>
                controller.provTujuanId.value = value?.provinceId ?? "",
          ),
          SizedBox(
            height: 10,
          ),
          DropdownSearch<City>(
            popupProps: PopupProps.menu(
              itemBuilder: (context, item, isSelected) => ListTile(
                title: Text("${item.type ?? ''} ${item.cityName ?? ''}"),
              ),
              showSearchBox: true,
              searchFieldProps: TextFieldProps(
                autocorrect: false,
              ),
            ),
            asyncItems: (text) async {
              var response = await Dio().get(
                  "https://api.rajaongkir.com/starter/city?province=${controller.provTujuanId}",
                  queryParameters: {"key": "bfb1c85fc202eff94c738f691617bc5c"});

              return City.fromJsonList(response.data["rajaongkir"]["results"]);
            },
            dropdownDecoratorProps: const DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                labelText: "Kota Tujuan",
                hintText: "Pilih  Kota",
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                border: OutlineInputBorder(),
              ),
            ),
            onChanged: (value) =>
                controller.cityTujuanId.value = value?.cityId ?? "",
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            controller: controller.weightC,
            autocorrect: false,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: "Berat (gram)",
              hintText: "Isi Berat",
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          DropdownSearch<Map<String, dynamic>>(
            items: [
              {
                "code": "jne",
                "name": "JNE",
              },
              {
                "code": "pos",
                "name": "POS INDONESIA",
              },
              {
                "code": "tiki",
                "name": "TIKI",
              }
            ],
            popupProps: PopupProps.menu(
              itemBuilder: (context, item, isSelected) => ListTile(
                title: Text("${item["name"]}"),
              ),
              showSearchBox: true,
              searchFieldProps: TextFieldProps(
                autocorrect: false,
              ),
            ),
            dropdownDecoratorProps: const DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                labelText: "Ekspedisi",
                hintText: "Pilih  Ekspedisi",
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                border: OutlineInputBorder(),
              ),
            ),
            dropdownBuilder: (context, selectedItem) =>
                Text("${selectedItem?["name"] ?? ""}"),
            onChanged: (value) =>
                controller.codeEkspedisi.value = value?['code'] ?? "",
          ),
          SizedBox(
            height: 20,
          ),
          Obx(() => ElevatedButton(
                onPressed: () {
                  if (controller.isLoading.isFalse) {
                    controller.cekOngkir();
                  }
                },
                child: Text(
                    controller.isLoading.isFalse ? "Cek Ongkir" : "Loading"),
              ))
        ],
      ),
    );
  }
}
