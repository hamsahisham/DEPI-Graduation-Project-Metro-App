import 'package:flutter/material.dart';
import 'package:metrostation_app/cover_page.dart';
import 'package:get/get.dart';
import 'translation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      translations: MyTranslations(), // Add translations here
      locale: Locale('en'), // Default locale
      fallbackLocale: Locale('en'),
      home: CoverPage(),
    );
  }
}
