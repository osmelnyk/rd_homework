import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rd_homework/utils/constants.dart';

// Dark Mode Change
class DarkModeNotifier extends StateNotifier<bool> {
  DarkModeNotifier() : super(false);

  void toggle() {
    state = !state;
  }
}

final darkModeProvider = StateNotifierProvider<DarkModeNotifier, bool>(
  (ref) => DarkModeNotifier(),
);

// Font Size Change
class FontSizeNotifier extends StateNotifier<bool> {
  FontSizeNotifier() : super(false);

  void toggle() {
    state = !state;
  }
}

final fontSizeProvider = StateNotifierProvider<FontSizeNotifier, bool>(
  (ref) => FontSizeNotifier(),
);

// Font family Change
class FontFamilyNotifier extends StateNotifier<AppFonts> {
  FontFamilyNotifier() : super(AppFonts.roboto);

  void updateFontFamily(AppFonts font) {
    state = font;
  }
}

final fontFamilyProvider = StateNotifierProvider<FontFamilyNotifier, AppFonts>(
    (ref) => FontFamilyNotifier());

// Locale Change
class LocaleNotifier extends StateNotifier<AppLanguages> {
  LocaleNotifier() : super(AppLanguages.system);

  void updateLanguage(AppLanguages languageCode) {
    state = languageCode;
  }
}

final localeProvider = StateNotifierProvider<LocaleNotifier, AppLanguages>(
    (ref) => LocaleNotifier());
