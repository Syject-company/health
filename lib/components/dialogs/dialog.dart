import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:health_plus/app_colors.dart';
import 'package:health_plus/app_resources.dart';

enum DialogType {
  warning,
  error,
  success,
}

Future<void> showHealthDialog(
  BuildContext context, {
  required DialogType type,
  required String contentText,
  required String actionText,
}) async {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) {
      return _Dialog(
        type: type,
        contentText: contentText,
        actionText: actionText,
      );
    },
  );
}

class _Dialog extends StatelessWidget {
  const _Dialog({
    Key? key,
    required this.type,
    required this.contentText,
    required this.actionText,
  }) : super(key: key);

  final DialogType type;
  final String contentText;
  final String actionText;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0.0,
      insetPadding: const EdgeInsets.all(24.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.0),
      ),
      child: Container(
        padding: const EdgeInsets.all(50.0),
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildIcon(),
            const SizedBox(height: 30.0),
            _buildMessage(),
            const SizedBox(height: 30.0),
            _buildActionButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon() {
    switch (type) {
      case DialogType.warning:
        return SvgPicture.asset(AppResources.dialogWarning);
      case DialogType.error:
        return SvgPicture.asset(AppResources.dialogError);
      case DialogType.success:
        return SvgPicture.asset(AppResources.dialogSuccess);
    }
  }

  Widget _buildMessage() {
    return Text(
      contentText,
      style: const TextStyle(
        fontSize: 16.0,
        fontFamily: 'Almarai',
        fontWeight: FontWeight.w800,
        color: AppColors.black,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildActionButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      style: TextButton.styleFrom(
        primary: AppColors.white,
        backgroundColor: AppColors.purple,
        padding: const EdgeInsets.symmetric(
          horizontal: 32.0,
          vertical: 0.0,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        fixedSize: const Size.fromHeight(48.0),
      ),
      child: Text(
        actionText,
        style: const TextStyle(
          fontSize: 14.0,
          fontFamily: 'Almarai',
          fontWeight: FontWeight.w700,
          color: AppColors.white,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
