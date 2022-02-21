import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:health_plus/app_colors.dart';
import 'package:health_plus/app_resources.dart';
import 'package:health_plus/router.dart';

class AppBarNotificationsButton extends StatelessWidget {
  const AppBarNotificationsButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        rootNavigator.pushNamed(RootRoutes.notifications);
      },
      style: TextButton.styleFrom(
        primary: AppColors.purple,
        fixedSize: const Size(40.0, 40.0),
        minimumSize: const Size(40.0, 40.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        backgroundColor: AppColors.purple.withOpacity(0.1),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: SvgPicture.asset(
        AppResources.notifications,
        width: 16.0,
        color: AppColors.purple,
      ),
    );
  }
}
