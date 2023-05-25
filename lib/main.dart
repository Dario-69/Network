import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:network/core/services/AuthService.dart';
import 'package:provider/provider.dart';
import 'package:network/core/models/users_model.dart';
//
import 'package:network/ui/config/router.dart';
import 'package:network/ui/config/style.dart';
import 'package:network/ui/views/starting/onboard.dart';
//
import 'package:firebase_core/firebase_core.dart';
import 'core/config/locator.dart';
import 'core/services/NavigationService.dart';
import 'firebase_options.dart';

void main() async {

  //
  setupLocator();

  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //SplashScreen Init
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MyApp());
  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return StreamProvider<UserModel?>.value(

      value: AuthenticationService().user,
      initialData: null,
      child: MaterialApp(
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        supportedLocales: const [
          Locale('en'),
          Locale('fr')
        ],
        title: "Network",
        theme: ThemeData(
          primaryColor: couleurPrincipale,
          fontFamily: GoogleFonts.poppins().fontFamily,
        ),
        debugShowCheckedModeBanner: false,
        home: const OnboardView(),
        onGenerateRoute: generateRoute,
        navigatorKey: locator<NavigationService>().navigationKey,
      )

    );

  }




}
