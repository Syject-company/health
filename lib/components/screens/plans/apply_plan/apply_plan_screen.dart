import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:health_plus/app_colors.dart';
import 'package:health_plus/components/screens/plans/bloc/plan/plan_bloc.dart';
import 'package:health_plus/components/shared_widgets/app_bar/health_app_bar.dart';
import 'package:health_plus/components/shared_widgets/health_card.dart';
import 'package:health_plus/components/shared_widgets/health_flat_button.dart';
import 'package:health_plus/components/shared_widgets/health_input.dart';
import 'package:health_plus/model/plan.dart';

class ApplyPlanScreen extends StatelessWidget {
  const ApplyPlanScreen({Key? key}) : super(key: key);

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
            body: _buildBody(context),
            bottomNavigationBar: _buildSubscribeButton(context),
          ),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    final plan = context.planBloc.state.plan;

    return SizedBox.expand(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitle(),
            const SizedBox(height: 24.0),
            _buildHeader(plan),
            const SizedBox(height: 28.0),
            _buildMainInformationLabel(),
            const SizedBox(height: 28.0),
            _buildMainInformationForm(),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      'text.subscription'.tr(),
      style: const TextStyle(
        fontSize: 20.0,
        fontFamily: 'Almarai',
        fontWeight: FontWeight.w700,
        color: AppColors.purpleDarkGrey,
      ),
    );
  }

  Widget _buildHeader(Plan plan) {
    return HealthCard(
      padding: const EdgeInsets.fromLTRB(42.0, 21.0, 42.0, 21.0),
      borderRadius: 21.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            plan.name,
            style: const TextStyle(
              fontSize: 14.0,
              fontFamily: 'Almarai',
              fontWeight: FontWeight.w700,
              color: AppColors.purple,
            ),
          ),
          const SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildPlanPrice(plan),
              _buildPlanDuration(plan),
            ],
          ),
        ],
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
            fontSize: 48.0,
            fontFamily: 'Almarai',
            fontWeight: FontWeight.w700,
            color: AppColors.purple,
          ),
        ),
        const SizedBox(width: 5.0),
        const Text(
          'RS',
          style: TextStyle(
            fontSize: 18.0,
            fontFamily: 'Almarai',
            fontWeight: FontWeight.w700,
            color: AppColors.purple,
          ),
        ),
      ],
    );
  }

  Widget _buildPlanDuration(Plan plan) {
    return const Text(
      '6 Months',
      style: TextStyle(
        fontSize: 18.0,
        fontFamily: 'Almarai',
        fontWeight: FontWeight.w700,
        color: AppColors.black,
      ),
    );
  }

  Widget _buildMainInformationLabel() {
    return Text(
      'text.main_information'.tr(),
      style: const TextStyle(
        fontSize: 20.0,
        fontFamily: 'Almarai',
        fontWeight: FontWeight.w700,
        color: AppColors.purpleDarkGrey,
      ),
    );
  }

  Widget _buildMainInformationForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HealthInput(
          labelText: 'input.full_name'.tr(),
          keyboardType: TextInputType.text,
        ),
        const SizedBox(height: 24.0),
        const HealthInput(
          labelText: 'National Identity',
          keyboardType: TextInputType.text,
        ),
        const SizedBox(height: 24.0),
        HealthInput(
          labelText: 'input.phone_number'.tr(),
          keyboardType: TextInputType.phone,
        ),
        const SizedBox(height: 24.0),
        const HealthInput(
          labelText: 'Address',
          keyboardType: TextInputType.emailAddress,
        ),
      ],
    );
  }

  Widget _buildSubscribeButton(BuildContext context) {
    return HealthFlatButton(
      onPressed: () {},
      text: 'button.subscribe_now'.tr(),
    );
  }
}
