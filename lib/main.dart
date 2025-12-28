import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'location_page.dart';
//import 'child.dart';
void main() async {

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Location Saver',
      locale: const Locale('en'), 
      supportedLocales: const [Locale('en'), Locale('ar')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        ],
      home: Directionality(
        textDirection: TextDirection.ltr,
        child: const LocationPage(),
        ),
    );
  }
}