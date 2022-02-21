import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:health_plus/app_constants.dart';
import 'package:health_plus/app_resources.dart';
import 'package:health_plus/components/screens/my_account/bloc/account_bloc.dart';
import 'package:health_plus/components/shared_widgets/app_bar/app_bar_back_button.dart';
import 'package:health_plus/components/shared_widgets/app_bar/app_bar_notifications_button.dart';
import 'package:health_plus/components/shared_widgets/app_bar/app_bar_user_profile.dart';
import 'package:health_plus/extensions/widget.dart';

class HealthAppBar extends StatelessWidget with PreferredSizeWidget {
  HealthAppBar({
    Key? key,
    this.backNavigation = false,
    this.notificationsButton = true,
  }) : super(key: key);

  final bool backNavigation;
  final bool notificationsButton;

  @override
  Size get preferredSize => const Size.fromHeight(AppConstants.appBarHeight);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildLeading(context),
        _buildTitle(),
        if (notificationsButton) _buildActions(),
      ],
    ).withPaddingSymmetric(16.0, 0.0);
  }

  Widget _buildLeading(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: backNavigation
          ? AppBarBackButton(onPressed: () {
              Navigator.of(context).pop();
            })
          : const AppBarUserProfile(),
    );
  }

  Widget _buildTitle() {
    return Align(
      alignment: AlignmentDirectional.center,
      child: SvgPicture.asset(
        AppResources.logoColored,
        height: 40.0,
      ),
    );
  }

  Widget _buildActions() {
    return BlocSelector<AccountBloc, AccountState, UserRole>(
      selector: (state) => state.role,
      builder: (_, role) {
        return Align(
          alignment: AlignmentDirectional.centerEnd,
          child: role == UserRole.user
              ? const AppBarNotificationsButton()
              : const SizedBox.shrink(),
        );
      },
    );
  }
}
