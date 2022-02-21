import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:health_plus/app_colors.dart';
import 'package:health_plus/app_resources.dart';

class AccountActionButton extends StatelessWidget {
  const AccountActionButton({
    Key? key,
    required this.onPressed,
    required this.iconPath,
    required this.text,
  }) : super(key: key);

  final VoidCallback onPressed;
  final String iconPath;
  final String text;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
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
          _buildArrowNextIcon(),
        ],
      ),
    );
  }

  Widget _buildIcon() {
    return SvgPicture.asset(
      iconPath,
      width: 16.0,
    );
  }

  Widget _buildText() {
    return Text(
      text.tr(),
      style: const TextStyle(
        fontSize: 14.0,
        fontFamily: 'Almarai',
        fontWeight: FontWeight.w400,
        color: AppColors.black,
      ),
    );
  }

  Widget _buildArrowNextIcon() {
    return Expanded(
      child: Align(
        alignment: AlignmentDirectional.centerEnd,
        child: SvgPicture.asset(
          AppResources.arrowNext2,
          matchTextDirection: true,
        ),
      ),
    );
  }
}
