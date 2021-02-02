import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:isbusiness/provider/provider.dart';
import 'package:isbusiness/router/router.dart';
import 'package:isbusiness/screens/splash/splashscreen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: providers,
        child: MaterialApp(
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate
          ],
          supportedLocales: [
            const Locale('ru'),
          ],
          title: 'ISBUSINESS',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              primarySwatch: const MaterialColor(
                0xFFFFFFFF,
                const <int, Color>{
                  50: const Color(0xFFFFFFFF),
                  100: const Color(0xFFFFFFFF),
                  200: const Color(0xFFFFFFFF),
                  300: const Color(0xFFFFFFFF),
                  400: const Color(0xFFFFFFFF),
                  500: const Color(0xFFFFFFFF),
                  600: const Color(0xFFFFFFFF),
                  700: const Color(0xFFFFFFFF),
                  800: const Color(0xFFFFFFFF),
                  900: const Color(0xFFFFFFFF),
                },
              ),
              visualDensity: VisualDensity.adaptivePlatformDensity
          ),
          onGenerateRoute: AppRouter.generateRoute,
          home: SplashScreen(),
        )
    );
  }
}



