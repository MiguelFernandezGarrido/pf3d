import 'package:flutter/material.dart';
import 'package:pf3d/shared_prefs/user_prefs.dart';
import 'package:provider/provider.dart';

import 'pages/home_screen_page.dart';
import 'pages/model_detail_page.dart';
import 'pages/tutorial_page.dart';
import 'providers/models_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserPrefs.init();
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ModelsProvider(), lazy: false),
      ],
      child: const MainApp(),
    );
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App Visor 3d',
      initialRoute: UserPrefs.getShowTutorial() ? '/tutorial' : '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/model_detail': (context) => const ModelDetail(),
        '/tutorial': (context) => const Tutorial(),
      },
      theme: ThemeData.dark()
          .copyWith(appBarTheme: const AppBarTheme(color: Colors.amber)),
    );
  }
}
