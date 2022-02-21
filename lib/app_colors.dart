import 'dart:ui';

abstract class AppColors {
  static const Color transparent = Color(0x00000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF434343);
  static const Color grey = Color(0xFF878787);
  static const Color lightGrey = Color(0xFFA8A8A8);
  static const Color orange = Color(0xFFF89A49);
  static const Color purple = Color(0xFF7D55C7);
  static const Color purpleLight = Color(0xFFE2DCED);
  static const Color purpleLightGrey = Color(0xFFB6B1C1);
  static const Color purpleDarkGrey = Color(0xFF625B6E);
  static const Color powderBlue = Color(0xFFEFFCFF);
  static const Color lightBlue = Color(0xFF8BD3E6);
  static const Color skyBlue = Color(0xFF64C4DD);
  static const Color lightGreen = Color(0xFF2ADAA4);

  static const Color inputLightGrey = Color(0xFFF6F5F6);
  static const Color inputDefaultBorder = Color(0xFFDEDEDE);
  static const Color inputFocusedBorder = Color(0xFF7D55C7);

  static const List<Color> scaffoldGradient = [lightBlue, purple];
  static final List<Color> cardPurpleGradient = [
    lightBlue.withOpacity(0.0),
    purple,
  ];
  static final List<Color> cardBlueGradient = [
    lightBlue.withOpacity(0.0),
    lightBlue,
  ];
}
