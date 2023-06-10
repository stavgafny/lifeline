import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class _AppConfig {
  Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();

    // Hides top and bottom status bars, display overlay on screen tap
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack, overlays: []);

    // Sets phone status bar and navigation bar color to transparant
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent));

    // Disabling http fetching for fonts, uses assets instead
    GoogleFonts.config.allowRuntimeFetching = false;

    // Adding the appropriate licenses to LicenseRegistry
    LicenseRegistry.addLicense(() async* {
      final license = await rootBundle.loadString('google_fonts/OFL.txt');
      yield LicenseEntryWithLineBreaks(['google_fonts'], license);
    });
  }
}

final appConfig = _AppConfig();
