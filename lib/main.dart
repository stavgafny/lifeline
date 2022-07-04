import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import '../constants/firebase_options.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import '../constants/theme_data.dart';
import 'routes/route_pages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Disabling http fetching for fonts, uses assets instead
  GoogleFonts.config.allowRuntimeFetching = false;

  // Adding the appropriate licenses to LicenseRegistry
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  final String title = "Lifeline";

  //! ROOT
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: title,
      theme: lightTheme,
      getPages: routePages,
      initialRoute: RoutePage.initial,
    );
  }
}
