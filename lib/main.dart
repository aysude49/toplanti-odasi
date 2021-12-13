import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:toplantiodasi/ekranlar/giris_ekrani.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [Locale('tr')],
      locale: Locale('tr'),
      title: 'Toplantı Odası Rezervasyon',
      home: GirisEkrani(),
    );
  }
}
