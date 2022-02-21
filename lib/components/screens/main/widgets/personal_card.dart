import 'dart:math' as math;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:health_plus/app_colors.dart';
import 'package:health_plus/app_resources.dart';
import 'package:health_plus/components/screens/my_account/bloc/account_bloc.dart';
import 'package:health_plus/extensions/sizer.dart';
import 'package:health_plus/extensions/widget.dart';
import 'package:health_plus/model/profile.dart';

class PersonalCard extends StatelessWidget {
  const PersonalCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildTitle(),
        const SizedBox(height: 20.0),
        Container(
          height: 152.0,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: AppColors.scaffoldGradient,
              begin: AlignmentDirectional.centerEnd,
              end: AlignmentDirectional.centerStart,
            ),
            borderRadius: BorderRadius.circular(19.0),
          ),
          child: Stack(
            fit: StackFit.expand,
            alignment: Alignment.center,
            children: [
              Image.asset(
                AppResources.cardBackgroundDrops,
                repeat: ImageRepeat.repeat,
                fit: BoxFit.cover,
              ),
              Align(
                alignment: AlignmentDirectional.bottomStart,
                child: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.rotationY(math.pi),
                  child: SvgPicture.asset(
                    AppResources.cardBackgroundIcon,
                    matchTextDirection: true,
                  ),
                ),
              ),
              PositionedDirectional(
                top: 18.0,
                end: 24.0,
                child: SvgPicture.asset(
                  AppResources.logoWithLabelWhite,
                  height: 52.0,
                ),
              ),
              _buildCardInformation(),
            ],
          ),
        ).withPaddingSymmetric(16.0, 0.0),
      ],
    );
  }

  Widget _buildTitle() {
    return Text(
      'text.my_card'.tr(),
      style: const TextStyle(
        fontSize: 16.0,
        fontFamily: 'Almarai',
        fontWeight: FontWeight.w700,
        color: AppColors.black,
      ),
    ).withPaddingSymmetric(16.0, 0.0);
  }

  Widget _buildCardInformation() {
    return BlocSelector<AccountBloc, AccountState, Profile>(
      selector: (state) => state.profile,
      builder: (_, profile) {
        return PositionedDirectional(
          end: 24.0,
          bottom: 24.0,
          width: 34.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${profile.firstName} ${profile.lastName}'.trim(),
                style: const TextStyle(
                  fontSize: 12.0,
                  fontFamily: 'Almarai',
                  fontWeight: FontWeight.w700,
                  color: AppColors.white,
                ),
              ),
              const SizedBox(height: 4.0),
              Row(
                children: const [
                  Expanded(
                    child: Text(
                      '05/23',
                      style: TextStyle(
                        fontSize: 12.0,
                        fontFamily: 'Almarai',
                        fontWeight: FontWeight.w700,
                        color: AppColors.white,
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ),
                  SizedBox(width: 16.0),
                  Expanded(
                    child: Text(
                      '239495',
                      style: TextStyle(
                        fontSize: 12.0,
                        fontFamily: 'Almarai',
                        fontWeight: FontWeight.w700,
                        color: AppColors.white,
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
