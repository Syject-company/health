import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:health_plus/app_colors.dart';
import 'package:health_plus/app_resources.dart';
import 'package:health_plus/components/shared_widgets/app_bar/health_app_bar.dart';
import 'package:health_plus/components/shared_widgets/health_button.dart';
import 'package:health_plus/components/shared_widgets/separated_column.dart';

class MyPackageScreen extends StatelessWidget {
  const MyPackageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: AppColors.white,
            appBar: HealthAppBar(backNavigation: true),
            body: _buildBody(),
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return SizedBox.expand(
      child: SingleChildScrollView(
        padding: const EdgeInsetsDirectional.only(
          start: 16.0,
          top: 8.0,
          bottom: 16.0,
          end: 16.0,
        ),
        child: Column(
          children: [
            _buildTitle(),
            const SizedBox(height: 24.0),
            _buildSubscriptionPlan(),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Text(
        'text.my_package'.tr(),
        style: const TextStyle(
          fontSize: 20.0,
          fontFamily: 'Almarai',
          fontWeight: FontWeight.w700,
          color: AppColors.purpleDarkGrey,
        ),
      ),
    );
  }

  Widget _buildSubscriptionPlan() {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(top: 28.0),
          padding: const EdgeInsets.only(
            left: 21.0,
            top: 60.0,
            right: 21.0,
            bottom: 32.0,
          ),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment(1.0, -2.0),
              end: Alignment.bottomLeft,
              colors: AppColors.scaffoldGradient,
            ),
            borderRadius: BorderRadius.circular(22.0),
          ),
          child: Column(
            children: [
              _buildPlanPrice(),
              const SizedBox(height: 8.0),
              _buildPlanDuration(),
              const SizedBox(height: 16.0),
              _buildPlanExpiration(),
              const SizedBox(height: 32.0),
              _buildPlanBonuses(),
              const SizedBox(height: 32.0),
              _buildRenewButton(),
            ],
          ),
        ),
        _buildPlanType(),
      ],
    );
  }

  Widget _buildPlanType() {
    return Container(
      height: 56.0,
      padding: const EdgeInsets.symmetric(horizontal: 42.0),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(26.0),
        border: Border.all(color: AppColors.purple),
      ),
      child: const Center(
        widthFactor: 1.0,
        child: Text(
          'Standard Plan',
          style: TextStyle(
            fontSize: 18.0,
            fontFamily: 'Almarai',
            fontWeight: FontWeight.w700,
            color: AppColors.purple,
          ),
        ),
      ),
    );
  }

  Widget _buildPlanPrice() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Text(
          '500',
          style: TextStyle(
            fontSize: 64.0,
            fontFamily: 'Almarai',
            fontWeight: FontWeight.w700,
            color: AppColors.white,
          ),
        ),
        SizedBox(width: 5.0),
        Text(
          'RS',
          style: TextStyle(
            fontSize: 24.0,
            fontFamily: 'Almarai',
            fontWeight: FontWeight.w700,
            color: AppColors.white,
          ),
        )
      ],
    );
  }

  Widget _buildPlanDuration() {
    return const Text(
      '6 Months',
      style: TextStyle(
        fontSize: 27.0,
        fontFamily: 'Almarai',
        fontWeight: FontWeight.w700,
        color: AppColors.white,
      ),
    );
  }

  Widget _buildPlanExpiration() {
    return Container(
      height: 52.0,
      padding: const EdgeInsets.symmetric(horizontal: 21.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: AppColors.white),
      ),
      child: const Center(
        widthFactor: 1.0,
        child: Text(
          'Expired date: 10 May, 2021',
          style: TextStyle(
            fontSize: 18.0,
            fontFamily: 'Almarai',
            fontWeight: FontWeight.w700,
            color: AppColors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildPlanBonuses() {
    Widget buildPlanBonus(String bonus) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(child: SvgPicture.asset(AppResources.check)),
          const SizedBox(width: 16.0),
          Expanded(
            child: Text(
              bonus,
              style: const TextStyle(
                fontSize: 15.0,
                fontFamily: 'Almarai',
                fontWeight: FontWeight.w400,
                color: AppColors.white,
              ),
            ),
          ),
        ],
      );
    }

    return SeparatedColumn(
      separator: const SizedBox(height: 16.0),
      children: [
        buildPlanBonus('5 Coupons for discount'),
        buildPlanBonus('Subscribe to 10 offers'),
        buildPlanBonus('You can visit 10 centers'),
        buildPlanBonus('2000 rs to ophthalmologist'),
        buildPlanBonus('Subscribe to 10 offers'),
      ],
    );
  }

  Widget _buildRenewButton() {
    return HealthButton(
      onPressed: () {},
      backgroundColor: AppColors.lightBlue,
      child: Text(
        'button.renew_subscription'.tr(),
        style: const TextStyle(
          fontSize: 15.0,
          fontFamily: 'Almarai',
          fontWeight: FontWeight.w700,
          color: AppColors.white,
        ),
      ),
    );
  }
}
