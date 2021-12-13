import 'package:flutter/material.dart';
import 'package:toplantiodasi/modeller/salon_model.dart';
import 'package:toplantiodasi/servisler/rezervasyon_servis.dart';

class SalonRezervasyon extends StatefulWidget {
  final SalonModel secilenSalon;
  const SalonRezervasyon({Key? key, required this.secilenSalon})
      : super(key: key);

  @override
  _SalonRezervasyonState createState() => _SalonRezervasyonState();
}

class _SalonRezervasyonState extends State<SalonRezervasyon> {
  String tarihString = '';
  DateTime? tarih = DateTime.now();
  @override
  void initState() {
    super.initState();
    tarihString = '${tarih!.day}-${tarih!.month}-${tarih!.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.secilenSalon.isim),
      ),
      body: buildBody,
    );
  }

  Widget get buildBody {
    return Column(
      children: [
        tarihSecim(),
        const Divider(),
        rezervasyonSaatleri(),
      ],
    );
  }

  Widget tarihSecim() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
          onTap: () => tarihAlert(),
          child: Text('Tarih: ' + tarihString,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ))),
    );
  }

  Widget rezervasyonSaatleri() {
    return FutureBuilder(
        future: RezervasyonServis.rezervasyonSorgula(
            widget.secilenSalon.id, tarih!),
        builder: (context, snapshot) {
          List<Map> saatler = [];
          for (var element in RezervasyonServis.musaitSaatListesi) {
            saatler.add({'saat': element, 'musait': true});
          }
          for (var element in RezervasyonServis.rezervasyonListesi) {
            saatler.add({'saat': element.saat, 'musait': false});
          }
          saatler.sort((a, b) => a['saat'].compareTo(b['saat']));
          if (snapshot.connectionState == ConnectionState.done) {
            return Column(
              children: [
                const Text('Uygun saatler yeşil ile gösterilmiştir.'),
                Row(
                  children: [
                    const Expanded(flex: 2, child: SizedBox()),
                    Expanded(
                      flex: 5,
                      child: Wrap(
                        children: [
                          ...saatler.map((e) => rezervasyonKart(
                              e['saat'].toString(), e['musait']))
                        ],
                      ),
                    ),
                    const Expanded(flex: 2, child: SizedBox()),
                  ],
                ),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget rezervasyonKart(String saat, bool musait) {
    return InkWell(
      onTap: () {
        musait
            ? rezervasyonAlert(saat)
            : ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content:
                    Text('Seçmiş olduğunuz saatte salon müsait değildir.')));
      },
      child: Container(
        margin: const EdgeInsets.all(15),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: musait ? Colors.green : Colors.blueGrey,
        ),
        child: Text(
          saat,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  void rezervasyonAlert(String saat) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Onaylıyor Musunuz'),
              content: Text(
                  '$tarihString $saat için ${widget.secilenSalon.isim} isimli salona rezervasyon yapıyorsunuz.'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('İptal')),
                ElevatedButton(
                    onPressed: () async {
                      await RezervasyonServis.rezervasyonYap(
                        widget.secilenSalon.id,
                        saat,
                        tarih!.day,
                        tarih!.month,
                        tarih!.year,
                      );
                      Navigator.pop(context);
                      setState(() {});
                    },
                    child: const Text('Onayla'))
              ],
            ));
  }

  void tarihAlert() async {
    tarih = await showDatePicker(
        context: context,
        initialDate: tarih!,
        firstDate: DateTime(DateTime.now().year, 1, 1),
        lastDate: DateTime(DateTime.now().year + 2, 12, 31));
    tarihString = '${tarih!.day}-${tarih!.month}-${tarih!.year}';
    setState(() {});
  }
}
