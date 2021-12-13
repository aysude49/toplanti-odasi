import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:toplantiodasi/modeller/kullanici_model.dart';
import 'package:toplantiodasi/modeller/rezervasyon_model.dart';

class RezervasyonServis {
  static var db = FirebaseFirestore.instance;
  static List<RezervasyonModel> rezervasyonListesi = [];
  static List<String> musaitSaatListesi = [];

  static Future rezervasyonSorgula(String salonid, DateTime tarih) async {
    rezervasyonListesi.clear();
    musaitSaatListesi = [
      '00:00',
      '01:00',
      '02:00',
      '03:00',
      '04:00',
      '05:00',
      '06:00',
      '07:00',
      '08:00',
      '09:00',
      '10:00',
      '11:00',
      '12:00',
      '13:00',
      '14:00',
      '15:00',
      '16:00',
      '17:00',
      '18:00',
      '19:00',
      '20:00',
      '21:00',
      '22:00',
      '23:00',
    ];
    await db
        .collection('salonlar')
        .doc(salonid)
        .collection('rezervasyonlar')
        .where('gun', isEqualTo: tarih.day)
        .where('ay', isEqualTo: tarih.month)
        .where('yil', isEqualTo: tarih.year)
        .get()
        .then((value) {
      for (var snapshot in value.docs) {
        rezervasyonListesi.add(RezervasyonModel.fromSnapshot(snapshot));
        musaitSaatListesi.remove(RezervasyonModel.fromSnapshot(snapshot).saat);
      }
    });
  }

  static Future rezervasyonYap(
      String salonid, String saat, num gun, num ay, num yil) async {
    await db
        .collection('salonlar')
        .doc(salonid)
        .collection('rezervasyonlar')
        .add({
      'gun': gun,
      'ay': ay,
      'yil': yil,
      'saat': saat,
      'kullaniciid': KullaniciModel.uid,
    }).then((value) => value.update({'id': value.id}));
  }
}
