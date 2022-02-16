import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:health_plus/app_colors.dart';
import 'package:health_plus/app_constants.dart';
import 'package:health_plus/app_resources.dart';

class ChangeLanguageButton extends StatefulWidget {
  const ChangeLanguageButton({Key? key}) : super(key: key);

  @override
  _ChangeLanguageButtonState createState() => _ChangeLanguageButtonState();
}

class _ChangeLanguageButtonState extends State<ChangeLanguageButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        final currentLocale = context.locale;
        final nextLocale = AppConstants.locales.firstWhere((locale) {
          return currentLocale != locale;
        });
        context.setLocale(nextLocale);
      },
      style: TextButton.styleFrom(
        primary: AppColors.purple,
        backgroundColor: AppColors.transparent,
        padding: const EdgeInsets.symmetric(
          horizontal: 28.0,
          vertical: 0.0,
        ),
        shape: const RoundedRectangleBorder(),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        minimumSize: const Size.fromHeight(54.0),
        fixedSize: const Size.fromHeight(54.0),
      ),
      child: Row(
        children: [
          _buildIcon(),
          const SizedBox(width: 16.0),
          _buildText(),
          const SizedBox(width: 16.0),
          _buildLanguageText(),
          const SizedBox(width: 12.0),
          _buildArrowNextIcon(),
        ],
      ),
    );
  }

  Widget _buildIcon() {
    return SvgPicture.asset(
      AppResources.language,
      width: 16.0,
    );
  }

  Widget _buildText() {
    return Text(
      'button.change_language'.tr(),
      style: const TextStyle(
        fontSize: 14.0,
        fontFamily: 'Almarai',
        fontWeight: FontWeight.w400,
        color: AppColors.black,
      ),
    );
  }

  Widget _buildLanguageText() {
    final currentLocale = context.locale;
    final nextLocale = AppConstants.locales.firstWhere((locale) {
      return currentLocale != locale;
    });
    String language = 'N/A';
    if (nextLocale == const Locale('en')) {
      language = 'English';
    } else if (nextLocale == const Locale('ar')) {
      language = 'العربية';
    }

    return Expanded(
      child: Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Text(
          language,
          style: const TextStyle(
            fontSize: 14.0,
            fontFamily: 'Almarai',
            fontWeight: FontWeight.w400,
            decoration: TextDecoration.underline,
            color: AppColors.purple,
          ),
        ),
      ),
    );
  }

  Widget _buildArrowNextIcon() {
    return SvgPicture.asset(
      AppResources.arrowNext2,
      matchTextDirection: true,
    );
  }
}
