import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:health_plus/app_colors.dart';
import 'package:health_plus/app_constants.dart';
import 'package:health_plus/app_resources.dart';
import 'package:health_plus/components/screens/my_account/bloc/account_bloc.dart';
import 'package:health_plus/extensions/sizer.dart';
import 'package:health_plus/extensions/widget.dart';
import 'package:health_plus/router.dart';
import 'package:health_plus/utils/session_manager.dart';

class AppBarUserProfile extends StatelessWidget {
  const AppBarUserProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    EasyLocalization.of(context)?.locale;

    return GestureDetector(
      onTap: Feedback.wrapForTap(
        () async {
          if (await SessionManager.isAuthenticated) {
            rootNavigator.pushNamed(RootRoutes.personalData);
          }
        },
        context,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildAvatar(),
          const SizedBox(width: 10.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildWelcomeText(),
              const SizedBox(height: 4.0),
              _buildFullName(),
            ],
          ),
        ],
      ),
      behavior: HitTestBehavior.opaque,
    );
  }

  Widget _buildWelcomeText() {
    return Text(
      'text.hello'.tr(),
      style: TextStyle(
        fontSize: 14.0,
        fontFamily: 'Almarai',
        fontWeight: FontWeight.w400,
        color: AppColors.purpleDarkGrey.withOpacity(0.63),
      ),
    );
  }

  Widget _buildFullName() {
    return BlocSelector<AccountBloc, AccountState, String>(
      selector: (state) {
        return '${state.profile.firstName} ${state.profile.lastName}'.trim();
      },
      builder: (_, fullName) {
        return SizedBox(
          width: 40.w - 58.0,
          child: AutoSizeText(
            fullName,
            maxLines: 2,
            softWrap: true,
            style: const TextStyle(
              fontSize: 14.0,
              fontFamily: 'Almarai',
              fontWeight: FontWeight.w400,
              color: AppColors.purpleDarkGrey,
            ),
          ),
        );
      },
    );
  }

  Widget _buildAvatar() {
    return BlocSelector<AccountBloc, AccountState, String?>(
      selector: (state) {
        return state.profile.avatar;
      },
      builder: (_, avatar) {
        return Container(
          width: 32.0,
          height: 32.0,
          decoration: BoxDecoration(
            color: avatar == null
                ? AppColors.purpleLightGrey.withOpacity(0.25)
                : AppColors.transparent,
            shape: BoxShape.circle,
          ),
          clipBehavior: Clip.hardEdge,
          child: avatar != null
              ? CachedNetworkImage(
                  imageUrl: '${AppConstants.apiUrl}$avatar',
                  placeholder: (_, __) {
                    return const CircularProgressIndicator(
                      color: AppColors.purple,
                      strokeWidth: 3.0,
                    ).withPaddingAll(2.0);
                  },
                  fit: BoxFit.cover,
                )
              : Center(child: SvgPicture.asset(AppResources.avatar)),
        );
      },
    );
  }
}
