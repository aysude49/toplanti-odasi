import 'package:flutter/material.dart';
import 'package:toplantiodasi/ekranlar/kayit_ekrani.dart';
import 'package:toplantiodasi/servisler/kullanici_servis.dart';

class GirisEkrani extends StatefulWidget {
  const GirisEkrani({Key? key}) : super(key: key);

  @override
  _GirisEkraniState createState() => _GirisEkraniState();
}

class _GirisEkraniState extends State<GirisEkrani> {
  var emailcont = TextEditingController();
  var passcont = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Toplantı Otomasyonu Giriş Ekranı'),
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
        buildTF('Şifre', '********', passcont, true),
        const SizedBox(height: 20),
        Align(alignment: Alignment.centerRight, child: hesapOlusturButon()),
        girisButon()
      ],
    );
  }

  Widget hesapOlusturButon() {
    return InkWell(
      onTap: () => Navigator.push(context,
          MaterialPageRoute(builder: (context) => const KayitEkrani())),
      child: const Text('Hesap Oluştur'),
    );
  }

  Widget girisButon() {
    return ElevatedButton(
        onPressed: () =>
            KullaniciServis.girisYap(context, emailcont.text, passcont.text),
        child: const Text('Giriş Yap'));
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
                prefixIcon: pass
                    ? const Icon(Icons.lock, color: Colors.white)
                    : const Icon(Icons.email, color: Colors.white),
                hintText: hinttext,
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
