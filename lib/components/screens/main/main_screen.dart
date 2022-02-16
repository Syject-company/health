import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:health_plus/app_colors.dart';
import 'package:health_plus/app_resources.dart';
import 'package:health_plus/components/screens/my_account/bloc/account_bloc.dart';
import 'package:health_plus/components/shared_widgets/health_button.dart';
import 'package:health_plus/components/shared_widgets/health_icon_button.dart';
import 'package:health_plus/components/shared_widgets/health_outlined_button.dart';
import 'package:health_plus/components/shared_widgets/health_search_input.dart';
import 'package:health_plus/extensions/widget.dart';
import 'package:health_plus/utils/elevation.dart';

import 'widgets/banners.dart';
import 'widgets/categories.dart';
import 'widgets/join_as_provider_card.dart';
import 'widgets/personal_card.dart';
import 'widgets/top_rated_hospitals.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: AppColors.white,
            body: _buildBody(),
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return BlocSelector<AccountBloc, AccountState, UserRole>(
      selector: (state) => state.role,
      builder: (_, role) {
        if (role == UserRole.user) {
          return SizedBox.expand(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildSearch(),
                  const SizedBox(height: 20.0),
                  const PersonalCard(),
                  const SizedBox(height: 20.0),
                  Categories(),
                  const SizedBox(height: 24.0),
                  Banners(
                    options: BannersOptions(height: 168.0),
                    items: [
                      _buildBannerItem(),
                      _buildBannerItem(),
                      _buildBannerItem(),
                    ],
                  ),
                  const SizedBox(height: 24.0),
                  const JoinAsProviderCard(),
                  const SizedBox(height: 24.0),
                  TopRatedHospitals(),
                  const SizedBox(height: 24.0),
                  _buildSubscribeInfo(),
                ],
              ),
            ),
          );
        }

        return SizedBox.expand(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildSearch(),
                const SizedBox(height: 20.0),
                Banners(
                  options: BannersOptions(height: 168.0),
                  items: [
                    _buildBannerItem(),
                    _buildBannerItem(),
                    _buildBannerItem(),
                  ],
                ),
                const SizedBox(height: 20.0),
                Categories(),
                const SizedBox(height: 24.0),
                _buildSubscribeInfo(),
                const SizedBox(height: 24.0),
                const JoinAsProviderCard(),
                const SizedBox(height: 24.0),
                TopRatedHospitals(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSearch() {
    return Row(
      children: [
        Expanded(
          child: HealthSearchInput(
            hintText: 'input.how_can_we_help_you'.tr(),
          ),
        ),
        const SizedBox(width: 12.0),
        Elevation(
          color: AppColors.purple.withOpacity(0.25),
          offset: const Offset(0.0, 10.0),
          blurRadius: 30.0,
          child: HealthIconButton(
            onPressed: () {},
            width: 48.0,
            height: 48.0,
            borderRadius: 14.0,
            child: SvgPicture.asset(AppResources.filters),
          ),
        ),
      ],
    ).withPaddingSymmetric(16.0, 0.0);
  }

  Widget _buildBannerItem() {
    return Stack(
      fit: StackFit.expand,
      alignment: Alignment.center,
      children: [
        CachedNetworkImage(
          imageUrl:
              'https://st.depositphotos.com/1005404/1324/i/950/depositphotos_13240275-stock-photo-build-hospital.jpg',
          fit: BoxFit.cover,
        ),
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: AppColors.cardPurpleGradient,
              begin: AlignmentDirectional.centerEnd
                  .resolve(Directionality.of(context)),
              end: AlignmentDirectional.centerStart
                  .resolve(Directionality.of(context)),
            ),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '50٪ off\nAli beauty centers',
                    style: TextStyle(
                      height: 1.5,
                      fontSize: 21.0,
                      fontFamily: 'Almarai',
                      fontWeight: FontWeight.w700,
                      color: AppColors.white,
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  HealthButton(
                    onPressed: () {},
                    backgroundColor: AppColors.lightBlue,
                    height: 38.0,
                    child: Text(
                      'button.subscribe_now'.tr(),
                      style: const TextStyle(
                        fontSize: 13.0,
                        fontFamily: 'Almarai',
                        fontWeight: FontWeight.w700,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 32.0),
            SvgPicture.asset(AppResources.watermark),
          ],
        ).withPadding(32.0, 24.0, 16.0, 24.0),
      ],
    );
  }

  Widget _buildSubscribeInfo() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 32.0,
        vertical: 21.0,
      ),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: AppColors.scaffoldGradient,
          begin: AlignmentDirectional.centerEnd,
          end: AlignmentDirectional.centerStart,
        ),
        borderRadius: BorderRadius.circular(19.0),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'text.subscribe_to_health_plus'.tr(),
              style: const TextStyle(
                height: 1.5,
                fontSize: 21.0,
                fontFamily: 'Almarai',
                fontWeight: FontWeight.w700,
                color: AppColors.white,
              ),
            ),
          ),
          const SizedBox(width: 16.0),
          HealthOutlinedButton(
            onPressed: () {},
            height: 38.0,
            child: Text(
              'button.subscribe_now'.tr(),
              style: const TextStyle(
                fontSize: 13.0,
                fontFamily: 'Almarai',
                fontWeight: FontWeight.w700,
                color: AppColors.white,
              ),
            ),
          ),
        ],
      ),
    ).withPaddingSymmetric(16.0, 0.0);
  }
}
