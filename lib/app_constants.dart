import 'dart:ui';

abstract class AppConstants {
  static const String apiUrl = 'http://46.101.29.20';
  static const String apiBaseUrl = 'http://46.101.29.20/v1';

  static const String accessTokenKey = 'access_token_key';
  static const String refreshTokenKey = 'refresh_token_key';

  static const String firstLaunchKey = 'first_launch_key';

  static const Locale defaultLocale = Locale('en');
  static const String i18nBasePath = 'assets/i18n';
  static const bool useCountryCode = false;
  static const List<Locale> locales = [
    Locale('en'),
    Locale('ar'),
  ];

  static const double appBarHeight = 84.0;
  static const double bottomNavigationBarHeight = 72.0;
}
