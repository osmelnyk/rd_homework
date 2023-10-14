import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rd_homework/providers.dart';
import 'package:rd_homework/utils/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Provides the current Settings values
    var darkMode = ref.watch(darkModeProvider);
    var fontSize = ref.watch(fontSizeProvider);
    var selectedFont = ref.watch(fontFamilyProvider);
    var locale = ref.watch(localeProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(AppLocalizations.of(context)!.settings),
      ),
      body: Column(
        children: [
          darkThemeSelector(darkMode, ref, context),
          fontSizeSelector(fontSize, ref, context),
          fontFamilySelector(context, selectedFont, ref),
          languageSelector(context, ref, locale),
        ],
      ),
    );
  }

  // Font size selector
  SwitchListTile fontSizeSelector(
      bool fontSize, WidgetRef ref, BuildContext context) {
    return SwitchListTile(
      value: fontSize,
      onChanged: (value) {
        ref.read(fontSizeProvider.notifier).toggle();
      },
      title: Text(
        AppLocalizations.of(context)!.biggerFont,
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }

  // Dark theme selector
  SwitchListTile darkThemeSelector(
      bool darkMode, WidgetRef ref, BuildContext context) {
    return SwitchListTile(
      value: darkMode,
      onChanged: (value) {
        ref.read(darkModeProvider.notifier).toggle();
      },
      title: Text(
        AppLocalizations.of(context)!.darkTheme,
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }

  // Font family selector
  ListTile fontFamilySelector(
      BuildContext context, AppFonts selectedFont, WidgetRef ref) {
    return ListTile(
      title: Text(
        AppLocalizations.of(context)!.fontFamily,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      trailing: DropdownButton<AppFonts>(
        // Remove the underline from the dropdown
        underline: Container(),
        value: selectedFont,
        padding: const EdgeInsets.only(left: 16, right: 16),
        borderRadius: BorderRadius.circular(16),
        items: AppFonts.values.map((font) {
          return DropdownMenuItem(
            value: font,
            child: Text(font.fontName),
          );
        }).toList(),
        onChanged: (value) {
          ref.read(fontFamilyProvider.notifier).updateFontFamily(value!);
        },
      ),
    );
  }

  // Language selector
  ListTile languageSelector(
      BuildContext context, WidgetRef ref, AppLanguages locale) {
    return ListTile(
      title: Text(
        AppLocalizations.of(context)!.language,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      trailing: SegmentedButton(
        selected: <AppLanguages>{locale},
        segments: <ButtonSegment<AppLanguages>>[
          ButtonSegment<AppLanguages>(
              value: AppLanguages.system,
              label: Text(AppLocalizations.of(context)!.systemLang)),
          ButtonSegment<AppLanguages>(
              value: AppLanguages.en,
              label: Text(AppLocalizations.of(context)!.english)),
          ButtonSegment<AppLanguages>(
              value: AppLanguages.uk,
              label: Text(AppLocalizations.of(context)!.ukrainian)),
        ],
        onSelectionChanged: (Set<AppLanguages> selectedLocale) {
          ref
              .read(localeProvider.notifier)
              .updateLanguage(selectedLocale.first);
        },
      ),
    );
  }
}
