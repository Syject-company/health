import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_plus/app_colors.dart';
import 'package:health_plus/components/shared_widgets/health_tab_bar.dart';
import 'package:health_plus/extensions/widget.dart';

import 'pages/coupons_page.dart';
import 'pages/offers_page.dart';

class OffersScreen extends StatelessWidget {
  const OffersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    EasyLocalization.of(context)?.locale;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitle(),
        const SizedBox(height: 24.0),
        Expanded(
          child: HealthTabBar(
            tabs: [
              HealthTabItem(label: 'button.offers'.tr()),
              HealthTabItem(label: 'button.coupons'.tr()),
            ],
            pages: [
              HealthTabPageItem(body: OffersPage()),
              HealthTabPageItem(body: CouponsPage()),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTitle() {
    return Text(
      'text.offers'.tr(),
      style: const TextStyle(
        fontSize: 28.0,
        fontFamily: 'Almarai',
        fontWeight: FontWeight.w700,
        color: AppColors.purpleDarkGrey,
      ),
    ).withPadding(16.0, 8.0, 16.0, 0.0);
  }
}
