import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import '../constants/firebase_options.dart';
import './constants/theme/theme.dart' as theme;
import './routes/route_pages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Sets phone status bar transparant
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

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
      theme: theme.lightTheme,
      darkTheme: theme.darkTheme,
      themeMode: ThemeMode.system,
      getPages: routePages,
      initialRoute: RoutePage.initial,
    );
  }
}
