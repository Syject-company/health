import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:health_plus/app_colors.dart';
import 'package:health_plus/app_resources.dart';
import 'package:health_plus/components/screens/plans/apply_plan/apply_plan_screen.dart';
import 'package:health_plus/components/screens/plans/bloc/plan/plan_bloc.dart';
import 'package:health_plus/components/shared_widgets/health_button.dart';
import 'package:health_plus/components/shared_widgets/separated_column.dart';
import 'package:health_plus/model/plan.dart';
import 'package:health_plus/router.dart';

class PlanView extends StatelessWidget {
  const PlanView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final plan = context.planBloc.state.plan;

    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          width: double.infinity,
          margin: const EdgeInsets.fromLTRB(0.0, 28.0, 0.0, 16.0),
          padding: const EdgeInsets.fromLTRB(21.0, 48.0, 21.0, 32.0),
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
              _buildPlanPrice(plan),
              const SizedBox(height: 8.0),
              _buildPlanDuration(),
              const SizedBox(height: 32.0),
              _buildPlanBonuses(),
              const SizedBox(height: 32.0),
              _buildRenewButton(context),
            ],
          ),
        ),
        _buildPlanType(plan),
      ],
    );
  }

  Widget _buildPlanType(Plan plan) {
    return Container(
      height: 56.0,
      padding: const EdgeInsets.symmetric(horizontal: 42.0),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(26.0),
        border: Border.all(color: AppColors.purple),
      ),
      child: Center(
        widthFactor: 1.0,
        child: Text(
          plan.name,
          style: const TextStyle(
            fontSize: 18.0,
            fontFamily: 'Almarai',
            fontWeight: FontWeight.w700,
            color: AppColors.purple,
          ),
        ),
      ),
    );
  }

  Widget _buildPlanPrice(Plan plan) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          plan.prices[0].price,
          style: const TextStyle(
            fontSize: 64.0,
            fontFamily: 'Almarai',
            fontWeight: FontWeight.w700,
            color: AppColors.white,
          ),
        ),
        const SizedBox(width: 5.0),
        const Text(
          'RS',
          style: TextStyle(
            fontSize: 24.0,
            fontFamily: 'Almarai',
            fontWeight: FontWeight.w700,
            color: AppColors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildPlanDuration() {
    return const Text(
      '6 Months',
      style: TextStyle(
        fontSize: 30.0,
        fontFamily: 'Almarai',
        fontWeight: FontWeight.w700,
        color: AppColors.white,
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
        buildPlanBonus('2000 rs to ophthalmologist'),
        buildPlanBonus('Subscribe to 10 offers'),
      ],
    );
  }

  Widget _buildRenewButton(BuildContext context) {
    return HealthButton(
      onPressed: () {
        rootNavigator.push(
          MaterialPageRoute(
            builder: (_) => BlocProvider.value(
              value: context.planBloc,
              child: const ApplyPlanScreen(),
            ),
          ),
        );
      },
      backgroundColor: AppColors.lightBlue,
      child: Text(
        'button.subscribe'.tr(),
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
