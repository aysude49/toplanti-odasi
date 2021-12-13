import 'package:flutter/material.dart';
import 'package:toplantiodasi/servisler/kullanici_servis.dart';

class KayitEkrani extends StatefulWidget {
  const KayitEkrani({Key? key}) : super(key: key);

  @override
  _KayitEkraniState createState() => _KayitEkraniState();
}

class _KayitEkraniState extends State<KayitEkrani> {
  var emailcont = TextEditingController();
  var passcont = TextEditingController();
  var isimcont = TextEditingController();
  var soyisimcont = TextEditingController();
  var telefoncont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Hesap Oluştur'),
      ),
      body: Row(
        children: [
          Expanded(flex: 2, child: Container()),
          Expanded(flex: 5, child: buildForm()),
          Expanded(flex: 2, child: Container()),
        ],
      ),
    );
  }

  Widget buildForm() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 20),
        buildTF('E-Mail', 'mail@mail.com', emailcont, false),
        const SizedBox(height: 20),
        buildTF('Şifre', '********', passcont, false),
        const SizedBox(height: 20),
        buildTF('İsim', 'Ahmet', isimcont, false),
        const SizedBox(height: 20),
        buildTF('Soyisim', 'Cansever', soyisimcont, false),
        const SizedBox(height: 20),
        buildTF('Telefon', '0500 789 12 34', telefoncont, false),
        const SizedBox(height: 20),
        signButton('Kayıt Ol')
      ],
    );
  }

  Widget signButton(String text) {
    return ElevatedButton(
        onPressed: () => KullaniciServis.kayitOl(context, emailcont.text,
            passcont.text, isimcont.text, soyisimcont.text, telefoncont.text),
        child: Text(text));
  }

  Widget buildTF(
      String text, String hinttext, TextEditingController cont, bool pass) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text),
        const SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.blueGrey,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: const [
              BoxShadow(
                color: Colors.black54,
                blurRadius: 2.5,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: TextField(
            autofocus: false,
            controller: cont,
            obscureText: pass,
            keyboardType: pass
                ? TextInputType.visiblePassword
                : TextInputType.emailAddress,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hinttext,
                prefix: const SizedBox(width: 10),
                hintStyle: const TextStyle(
                  letterSpacing: 1,
                  color: Colors.black54,
                )),
          ),
        ),
      ],
    );
  }
}
