import 'package:flutter/material.dart';
import 'package:toplantiodasi/ekranlar/salon_rezervasyon.dart';
import 'package:toplantiodasi/modeller/kullanici_model.dart';
import 'package:toplantiodasi/modeller/salon_model.dart';
import 'package:toplantiodasi/servisler/salon_servis.dart';

class AnaSayfa extends StatefulWidget {
  const AnaSayfa({Key? key}) : super(key: key);

  @override
  _AnaSayfaState createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
            'Hoşgeldiniz ${KullaniciModel.isim} ${KullaniciModel.soyisim}'),
      ),
      body: buildBody,
    );
  }

  Widget get buildBody {
    return Row(
      children: [
        Expanded(flex: 2, child: Container()),
        Expanded(
            flex: 7,
            child: GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisExtent: 280, crossAxisCount: 2),
              children: [
                ...SalonServis.salonListesi.map((e) => salonKart(e)),
              ],
            )),
        Expanded(flex: 2, child: Container()),
      ],
    );
  }

  Widget salonKart(SalonModel salon) {
    return Card(
      child: InkWell(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SalonRezervasyon(secilenSalon: salon))),
        child: Column(
          children: [
            Expanded(
                child: Image.asset(
              'assets/img/toplanti.jpg',
              fit: BoxFit.fill,
            )),
            ListTile(
              title: Text(salon.isim),
              subtitle:
                  Text('${salon.kapasite} kişi kapasiteli toplantı salonu.'),
            ),
          ],
        ),
      ),
    );
  }
}
