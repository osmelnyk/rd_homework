enum AppFonts {
  roboto('Roboto'),
  montserrat('Montserrat'),
  openSans('Open Sans');

  const AppFonts(this.fontName);
  final String fontName;
}

enum AppLanguages {
  system(null),
  en('en'),
  uk('uk');

  const AppLanguages(this.languageCode);
  final String? languageCode;
}
