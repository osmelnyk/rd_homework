import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'
// Conflicts with Provider, so we execlude it from the import
    hide
        ChangeNotifierProvider;
import 'package:provider/provider.dart';
// Localizations
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rd_homework/l10n/l10n.dart';
// Providers
import 'package:rd_homework/providers.dart';
import 'package:rd_homework/lesson13/product_provider.dart';
// Utils
import 'package:rd_homework/utils/theme.dart';
// Screens
import 'lesson14/notifiers/cart_notifier.dart';
import 'lesson14/notifiers/product_notifier.dart';
import 'lesson14/screens/product_list.dart';
import 'lesson13/screens/inherited.dart';
import 'lesson12/screens/task.dart';
import 'screens/settings_screen.dart';
import 'lesson9/lesson_screen.dart';
import 'lesson8/lesson_screen.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (_) => CartNotifier(),
    ),
    ChangeNotifierProvider(
      create: (_) => ProductNotifier(),
    ),
  ], child: const ProviderScope(child: MyApp())));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

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
      child: ProductProvider(
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
              '/lesson8': (context) => const LessonScreen8(),
              '/lesson9': (context) => const LessonScreen9(),
              '/lesson12': (context) => const TaskScreen(),
              '/lesson13': (context) => const InheritedScreen(),
              '/lesson14': (context) => const ProductsScreen(),
            }),
      ),
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
                Navigator.of(context).pushNamed('/lesson8');
              },
              child: Text('${AppLocalizations.of(context)!.lesson} 8'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/lesson9');
              },
              child: Text('${AppLocalizations.of(context)!.lesson} 9'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/lesson12');
              },
              child: Text('${AppLocalizations.of(context)!.lesson} 12'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/lesson13');
              },
              child: Text('${AppLocalizations.of(context)!.lesson} 13'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/lesson14');
              },
              child: Text('${AppLocalizations.of(context)!.lesson} 14'),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
