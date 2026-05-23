import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/constants/env_loader.dart';
import 'core/theme/theme_provider.dart';
import 'presentation/screens/home/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EnvLoader.load();

  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const GoldTrackApp(),
    ),
  );
}

class GoldTrackApp extends StatelessWidget {
  const GoldTrackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'GoldTrack Vietnam',
          theme: themeProvider.currentThemeData,
          debugShowCheckedModeBanner: false,
          home: const HomeScreen(),
        );
      },
    );
  }
}
