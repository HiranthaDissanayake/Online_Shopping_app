import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_shopping_app/components/bottomNavBar.dart';
import 'package:online_shopping_app/pages/home.dart';
import 'package:online_shopping_app/pages/login.dart';

void main() => runApp(
  DevicePreview(
    enabled: !kReleaseMode,
    builder: (context) => MyApp(), // Wrap your app
  ),
);
class MyApp extends StatelessWidget {
   const MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
  final textTheme = Theme.of(context).textTheme;
    return MaterialApp(
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
  theme: ThemeData(
    textTheme: GoogleFonts.latoTextTheme(textTheme).copyWith(
      bodyMedium: GoogleFonts.poppins(textStyle: textTheme.bodyMedium,),
    ),
  ),
  home: Login() ,
);
  }
}

