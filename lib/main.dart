import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// Localizations
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rd_homework/l10n/l10n.dart';
// Providers
import 'package:rd_homework/providers.dart';
// Utils
import 'package:rd_homework/utils/theme.dart';
// Screens
import 'screens/settings_screen.dart';
import 'lesson9/lesson_screen.dart';
import 'lesson8/lesson_screen.dart';

void main() => runApp(const ProviderScope(child: MyApp()));

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final darkMode = ref.watch(darkModeProvider);
    final fontSize = ref.watch(fontSizeProvider);
    final locale = ref.watch(localeProvider).languageCode;

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(
        // Changes the text scale factor
        textScaleFactor: fontSize ? 1.2 : 1.0,
      ),
      child: MaterialApp(
          title: 'Lessons RD',
          // Hide the debug banner in debug mode
          debugShowCheckedModeBanner: false,
          // Theming
          theme: lightTheme(ref),
          darkTheme: darkTheme(ref),
          themeMode: darkMode ? ThemeMode.dark : ThemeMode.light,

          // Localizations
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: L10n.all,
          locale: locale != null ? Locale(locale) : null,

          // Routing
          initialRoute: '/',
          routes: {
            '/': (context) =>
                HomeScreen(title: AppLocalizations.of(context)!.lessons),
            '/settings': (context) => const SettingsScreen(),
          }),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/settings');
            },
            icon: const Icon(Icons.settings),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const LessonScreen8()),
                );
              },
              child: Text('${AppLocalizations.of(context)!.lesson} 8'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const LessonScreen9()),
                );
              },
              child: Text('${AppLocalizations.of(context)!.lesson} 9'),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
