import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_plus/app_colors.dart';
import 'package:health_plus/components/shared_widgets/app_bar/health_app_bar.dart';
import 'package:health_plus/extensions/widget.dart';
import 'package:health_plus/utils/disallow_glow.dart';

import 'bloc/plan/plan_bloc.dart';
import 'bloc/plans/plans_bloc.dart';
import 'widgets/plan_view.dart';
import 'widgets/plans_page_view.dart';

class PlansScreen extends StatelessWidget {
  const PlansScreen({Key? key}) : super(key: key);

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
    return Column(
      children: [
        _buildTitle(),
        const SizedBox(height: 24.0),
        _buildPlansPageView(),
      ],
    );
  }

  Widget _buildTitle() {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Text(
        'text.subscription_plans'.tr(),
        style: const TextStyle(
          fontSize: 20.0,
          fontFamily: 'Almarai',
          fontWeight: FontWeight.w700,
          color: AppColors.purpleDarkGrey,
        ),
      ),
    ).withPadding(16.0, 8.0, 16.0, 0.0);
  }

  Widget _buildPlansPageView() {
    return BlocBuilder<PlansBloc, PlansState>(
      buildWhen: (_, state) {
        return state.status == PlansStatus.fetching ||
            state.status == PlansStatus.loaded;
      },
      builder: (_, state) {
        if (state.status == PlansStatus.fetching) {
          return const Expanded(
            child: Center(
              child: CircularProgressIndicator(
                color: AppColors.purple,
              ),
            ),
          );
        } else if (state.status == PlansStatus.loaded) {
          return Flexible(
            child: DisallowGlow(
              child: PlansPageView(
                options: PlansPageViewOptions(
                  viewportFraction: 0.9,
                  spaceBetween: 16.0,
                ),
                items: state.plans.map((plan) {
                  return SingleChildScrollView(
                    child: BlocProvider(
                      create: (context) => PlanBloc(plan: plan),
                      child: PlanView(),
                    ),
                  );
                }).toList(),
              ).withPadding(8.0, 0.0, 8.0, 0.0),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
