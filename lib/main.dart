import 'package:alarm_clock_app/setup.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home_page.dart';

void main() async {
  await setup();
  runApp(
    EasyLocalization(
      path: "assets/translations",
      supportedLocales: const [
        Locale("uz", "UZ"),
        Locale("en", "US"),
        Locale("ru", "RU")
      ],
      startLocale: const Locale("uz", "UZ"),
      child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      theme: ThemeData(textTheme: GoogleFonts.poppinsTextTheme()),
      home: const HomePage(),
    );
  }
}

