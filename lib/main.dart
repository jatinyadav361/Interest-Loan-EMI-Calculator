import 'package:flutter/material.dart';
import 'package:simple_interest_calculator/screens/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:simple_interest_calculator/screens/theme_dynamic.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: Consumer<ThemeNotifier>(
        builder: (context, ThemeNotifier notifier, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: SplashScreen(),
            theme: notifier.darkTheme? dark :light,
          );
        },
      ),
    );
  }
}
