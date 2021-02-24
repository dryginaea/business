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
          onGenerateRoute: AppRouter.generateRoute,
          home: SplashScreen(),
        )
    );
  }
}



