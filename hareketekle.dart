//import 'dart:html';
//import 'dart:developer';
//import 'dart:html';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datafstore/hareketlistele.dart';
import 'package:datafstore/main.dart';
import 'package:flutter/material.dart';
import 'main.dart';

class hareketekle extends StatefulWidget {
  DocumentSnapshot docid;
  hareketekle({required this.docid});

  @override
  _hareketekleState createState() => _hareketekleState();
}

class _hareketekleState extends State<hareketekle> {
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();
  TextEditingController t4 = TextEditingController(); //alacak
  TextEditingController t5 = TextEditingController(); //borç
  TextEditingController t6 = TextEditingController(); //gruplandırma
  TextEditingController t7 = TextEditingController(); //aciklama

  hareketEkle() {
    FirebaseFirestore.instance.collection("Hareket1").doc(title.text).set({
      't1' + DateTime.now().toString(): {
        'alacak': t4.text,
        'borç': t5.text,
        'açiklama': t7.text,
      },
    }).whenComplete(() => print("Hareket Eklendi"));
    //burası: map yapısıdır. değişken olarak tanımlanabilir
    // devre dışı bırakıldı, fonksiyon ilave edince eskileri siliyor
  }

  arrayEkle() {
    FirebaseFirestore.instance
        .collection("CariHareket")
        .doc(title.text)
        .update({
      //'alacak1': FieldValue.arrayUnion([t4.text]), yanlış kod,
      //süslü parantez noktayı koydu
      'hareketdetay': FieldValue.arrayUnion([
        {
          '     ***********************                              '
              'alacak': t4.text,
          'borc': t5.text,
          'tarih': DateTime.now().toString(),
          'aciklama': t7.text
        }
      ]),

      //'alacak2': FieldValue.arrayUnion([t4.text, DateTime.now(), t7.text]),
      //yanlış kod silmedim kalsın bakda gör
      //süslü parantez noktayı koydu
    }).whenComplete(() => print("Hareket Eklendi"));
    //burası: map yapısıdır. değişken olarak tanımlanabilir
  }

  GercekarrayEkle() {
    FirebaseFirestore.instance
        .collection("CariHareketGercek")
        .doc(title.text)
        .update({
      //'alacak1': FieldValue.arrayUnion([t4.text]), yanlış kod,
      //süslü parantez noktayı koydu
      'hareketdetay': FieldValue.arrayUnion([
        {
          '     ***********************                              '
              'alacak': t4.text,
          'borc': t5.text,
          'tarih': DateTime.now().toString(),
          'aciklama': t7.text
        }
      ]),

      //'alacak2': FieldValue.arrayUnion([t4.text, DateTime.now(), t7.text]),
      //yanlış kod silmedim kalsın bakda gör
      //süslü parantez noktayı koydu
    }).whenComplete(() => print("Hareket Eklendi"));
    //burası: map yapısıdır. değişken olarak tanımlanabilir
  }

  hareketGuncelle() {
    /*
    FirebaseFirestore.instance.collection("Hareket").doc(title.text).update({
      t6.text + Random().toString(): {
        'alacak': t4.text,
        'borc': t5.text,
        'tarih': DateTime.now(),
        'açıklama': t7.text
      },
      'tarih': DateTime.now(),
    }).whenComplete(() => print("yazı güncellendi")); */
  }

  @override
  void initState() {
    title = TextEditingController(text: widget.docid.get('baslik'));
    content = TextEditingController(text: widget.docid.get('icerik'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          MaterialButton(
            onPressed: () {
              widget.docid.reference.update({
                'baslik': title.text,
                'icerik': content.text,
              }).whenComplete(() {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => Iskele()));
              });
            },
            child: Text("save"),
          ),
          MaterialButton(
            onPressed: () {
              widget.docid.reference.delete().whenComplete(() {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => Iskele()));
              });
            },
            child: Text("delete"),
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(border: Border.all()),
              child: TextField(
                controller: title,
                decoration: InputDecoration(
                  hintText: 'baslik',
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(border: Border.all()),
                child: TextField(
                  controller: content,
                  //expands: true,
                  maxLines: null,
                  decoration: InputDecoration(
                    hintText: 'icerik',
                  ),
                ),
              ),
            ),
            //container lar üst üste gelmiştir. ölçü ver alt alta al,  bunu çöz
            //expands : true devre dışı bırakılınca düzeldi.
            Container(
              //color: Colors.red.shade400,
              child: Column(
                children: [
                  TextField(
                    //ALACAK
                    textAlign: TextAlign.center,
                    controller: t4,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Alacak giriniz',
                    ),
                  ),
                  TextField(
                    //BORÇ
                    textAlign: TextAlign.center,
                    controller: t5,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Borç giriniz',
                    ),
                  ),
                  /* TextField(
                    //gruplandırma
                    textAlign: TextAlign.center,
                    controller: t6,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Varsa Özel Kod Giriniz',
                    ),
                  ),*/
                  TextField(
                    //AÇIKLAMA
                    textAlign: TextAlign.center,
                    controller: t7,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Aciklama giriniz',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Row(
                        children: [
                          ElevatedButton(onPressed: () {}, child: Text("BOŞ")),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => hareketlistele()));
                              },
                              child: Text("LİSTELE")),
                          ElevatedButton(
                              onPressed: arrayEkle, child: Text("EKLE")),
                          ElevatedButton(
                              onPressed: hareketEkle,
                              child: Text("hareket1 ekle")),
                          ElevatedButton(
                              onPressed: GercekarrayEkle,
                              child: Text("GERÇEK EKLE")),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
