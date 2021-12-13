import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:toplantiodasi/ekranlar/anasayfa.dart';
import 'package:toplantiodasi/modeller/kullanici_model.dart';
import 'package:toplantiodasi/servisler/salon_servis.dart';

class KullaniciServis {
  static var auth = FirebaseAuth.instance;
  static var db = FirebaseFirestore.instance;

  static Future girisYap(
      BuildContext context, String mail, String sifre) async {
    await auth.signInWithEmailAndPassword(email: mail, password: sifre);
    await db
        .collection('kullanicilar')
        .doc(auth.currentUser!.uid)
        .get()
        .then((value) {
      KullaniciModel.fromSnapshot(value);
    });
    await SalonServis.toplantiOdalari();
    await Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const AnaSayfa()),
        (route) => false);
  }

  static Future kayitOl(BuildContext context, String mail, String sifre,
      String isim, String soyisim, String telefon) async {
    await auth.createUserWithEmailAndPassword(email: mail, password: sifre);
    await db.collection('kullanicilar').doc(auth.currentUser!.uid).set({
      'isim': isim,
      'uid': auth.currentUser!.uid,
      'soyisim': soyisim,
      'mail': mail,
      'telefon': telefon
    });
    girisYap(context, mail, sifre);
  }
}
