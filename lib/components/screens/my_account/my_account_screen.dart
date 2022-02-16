import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_plus/app_colors.dart';
import 'package:health_plus/app_resources.dart';
import 'package:health_plus/components/shared_widgets/separated_column.dart';
import 'package:health_plus/extensions/widget.dart';
import 'package:health_plus/router.dart';
import 'package:health_plus/utils/session_manager.dart';

import 'bloc/account_bloc.dart';
import 'widgets/account_action_button.dart';
import 'widgets/change_language_button.dart';

class MyAccountScreen extends StatelessWidget {
  const MyAccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    EasyLocalization.of(context)?.locale;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              _buildTitle(),
              const SizedBox(height: 28.0),
              _buildAccountActions(),
            ],
          ),
        ),
        SliverFillRemaining(
          hasScrollBody: false,
          child: _buildAuthenticationActions(),
        ),
      ],
    );
  }

  Widget _buildTitle() {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Text(
        'text.my_account'.tr(),
        style: const TextStyle(
          fontSize: 28.0,
          fontFamily: 'Almarai',
          fontWeight: FontWeight.w700,
          color: AppColors.purpleDarkGrey,
        ),
      ),
    ).withPadding(16.0, 8.0, 16.0, 0.0);
  }

  Widget _buildAccountActions() {
    return BlocSelector<AccountBloc, AccountState, UserRole>(
      selector: (state) => state.role,
      builder: (context, role) {
        return SeparatedColumn(
          includeOuterSeparators: true,
          includeOuterTop: false,
          separator: Divider(
            color: AppColors.purpleLightGrey.withOpacity(0.23),
            thickness: 1.0,
            height: 1.0,
          ),
          children: [
            if (role == UserRole.user)
              AccountActionButton(
                onPressed: () {
                  rootNavigator.pushNamed(RootRoutes.personalData);
                },
                iconPath: AppResources.profile,
                text: 'button.personal_data',
              ),
            if (role == UserRole.user)
              AccountActionButton(
                onPressed: () {
                  final hasSubscription =
                      context.accountBloc.state.profile.hasSubscription;
                  rootNavigator.pushNamed(hasSubscription
                      ? RootRoutes.myPackage
                      : RootRoutes.plans);
                },
                iconPath: AppResources.package,
                text: 'button.my_package',
              ),
            AccountActionButton(
              onPressed: () {
                rootNavigator.pushNamed(RootRoutes.privacy);
              },
              iconPath: AppResources.privacyPolicy,
              text: 'button.privacy_policy',
            ),
            AccountActionButton(
              onPressed: () {
                rootNavigator.pushNamed(RootRoutes.aboutUs);
              },
              iconPath: AppResources.aboutUs,
              text: 'button.about_us',
            ),
            AccountActionButton(
              onPressed: () {
                rootNavigator.pushNamed(RootRoutes.support);
              },
              iconPath: AppResources.support,
              text: 'button.support',
            ),
            if (role == UserRole.user)
              AccountActionButton(
                onPressed: () {
                  rootNavigator.pushNamed(RootRoutes.changePassword);
                },
                iconPath: AppResources.changePassword,
                text: 'button.change_password',
              ),
            const ChangeLanguageButton(),
          ],
        );
      },
    );
  }

  Widget _buildAuthenticationActions() {
    return BlocSelector<AccountBloc, AccountState, UserRole>(
      selector: (state) => state.role,
      builder: (context, role) {
        return Center(
          child: SeparatedColumn(
            mainAxisSize: MainAxisSize.min,
            includeOuterSeparators: true,
            separator: Divider(
              color: AppColors.purpleLightGrey.withOpacity(0.23),
              thickness: 1.0,
              height: 1.0,
            ),
            children: [
              if (role == UserRole.guest)
                AccountActionButton(
                  onPressed: () {
                    rootNavigator.pushReplacementNamed(RootRoutes.login);
                  },
                  iconPath: AppResources.login,
                  text: 'button.login',
                ),
              if (role == UserRole.user)
                AccountActionButton(
                  onPressed: () async {
                    await SessionManager.invalidate();
                    context.accountBloc.clearProfile();
                    rootNavigator.pushReplacementNamed(RootRoutes.login);
                  },
                  iconPath: AppResources.logout,
                  text: 'button.logout',
                )
            ],
          ),
        );
      },
    );
  }
}
