import 'package:flutter/material.dart';

import 'main.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class NotKayitSayfa extends StatefulWidget {
  @override
  _NotKayitSayfaState createState() => _NotKayitSayfaState();
}

class _NotKayitSayfaState extends State<NotKayitSayfa> {
  var tfDersAdi = TextEditingController();
  var tfNot1 = TextEditingController();
  var tfNot2 = TextEditingController();

  Future<void> kayit(String dersAdi, int not1, int not2) async {
    Uri url = Uri.http("kasimadalan.pe.hu", "/notlar/insert_not.php");
    var veri = {"ders_adi": dersAdi, "not1": not1.toString(), "not2": not2.toString()};
    var cevap = await http.post(url, body: veri);
    print("Not Ekle Cevap : $cevap");
    Navigator.push(context, MaterialPageRoute(builder: (context) => Anasayfa()));
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Not Kayıt"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextFormField(
                  controller: tfDersAdi,
                  decoration: InputDecoration(hintText: "Ders Adı"),
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return "Ders adı boş olamaz";
                    } else {
                      return null;
                    }
                  },
                ),
                TextFormField(
                  controller: tfNot1,
                  decoration: InputDecoration(hintText: "Not 1"),
                  keyboardType: TextInputType.number,
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return "Not 1 boş olamaz";
                    } else if (int.tryParse(text) == null) {
                      return "Lütfen not 1 için sayı giriniz";
                    } else {
                      return null;
                    }
                  },
                ),
                TextFormField(
                  controller: tfNot2,
                  decoration: InputDecoration(hintText: "Not 2"),
                  keyboardType: TextInputType.number,
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return "Not 2 boş olamaz";
                    } else if (int.tryParse(text) == null) {
                      return "Lütfen not 2 için sayı giriniz";
                    } else {
                      return null;
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (formKey.currentState.validate()) {
            kayit(tfDersAdi.text, int.parse(tfNot1.text), int.parse(tfNot2.text));
          }
        },
        tooltip: 'Not Kayıt',
        icon: Icon(Icons.save),
        label: Text("Kaydet"),
      ),
    );
  }
}
