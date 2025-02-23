// import 'package:device_preview/device_preview.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:online_shopping_app/Provider/cartProvider.dart';
// import 'package:provider/provider.dart';
// import 'package:online_shopping_app/components/bottomNavBar.dart';

// void main() {

//   // initialized Stripe 
//   WidgetsFlutterBinding.ensureInitialized();
//   Stripe.publishableKey = "pk_test_51QOMw0LI2fV9th4cJzazszhixLRe8EkTUuUmEzeZEpbFdFN1SQGPQhID9NoZT4WkuY85RGfm9NIhPxkDeMgMmgKk00sVU5rGeP"; 
//   runApp(

//     // Device Preview 
//     DevicePreview(
//       enabled: !kReleaseMode,
//       builder: (BuildContext context) {
//         return MultiProvider(
//         providers: [
//           ChangeNotifierProvider(create: (context) => CartProvider()),
//         ],
//         child: MyApp(),
//       );
//       },
//     ),
//   );
// }


// class MyApp extends StatelessWidget {
//    const MyApp({super.key});


//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//   final textTheme = Theme.of(context).textTheme;
//     return MaterialApp(
//       useInheritedMediaQuery: true,
//       locale: DevicePreview.locale(context),
//       builder: DevicePreview.appBuilder,
//       debugShowCheckedModeBanner: false,
//   theme: ThemeData(
//     textTheme: GoogleFonts.latoTextTheme(textTheme).copyWith(
//       bodyMedium: GoogleFonts.poppins(textStyle: textTheme.bodyMedium,),
//     ),
//   ),
//   home: Bottomnavbar(),
// );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_shopping_app/Provider/cartProvider.dart';
import 'package:online_shopping_app/pages/signup.dart';
import 'package:provider/provider.dart';

void main() {
  // Initialize Stripe
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = "pk_test_51QOMw0LI2fV9th4cJzazszhixLRe8EkTUuUmEzeZEpbFdFN1SQGPQhID9NoZT4WkuY85RGfm9NIhPxkDeMgMmgKk00sVU5rGeP";
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.latoTextTheme(textTheme).copyWith(
          bodyMedium: GoogleFonts.poppins(textStyle: textTheme.bodyMedium),
        ),
      ),
      home: SignUp(),
    );
  }
}

