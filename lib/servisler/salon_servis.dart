import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:toplantiodasi/modeller/salon_model.dart';

class SalonServis {
  static var db = FirebaseFirestore.instance;
  static List<SalonModel> salonListesi = [];

  static Future toplantiOdalari() async {
    salonListesi.clear();
    await db.collection('salonlar').get().then((value) {
      for (var snapshot in value.docs) {
        salonListesi.add(SalonModel.fromSnapshot(snapshot));
      }
    });
  }
}
