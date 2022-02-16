import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:health_plus/app_colors.dart';
import 'package:health_plus/app_resources.dart';
import 'package:health_plus/components/screens/hospital_details/pages/center_information_page.dart';
import 'package:health_plus/components/screens/medical_network/bloc/provider/provider_bloc.dart';
import 'package:health_plus/components/shared_widgets/app_bar/health_app_bar.dart';
import 'package:health_plus/components/shared_widgets/health_flat_icon_button.dart';
import 'package:health_plus/components/shared_widgets/health_tab_bar.dart';
import 'package:health_plus/extensions/widget.dart';
import 'package:health_plus/model/provider.dart';
import 'package:health_plus/utils/url_launcher.dart';

import 'pages/discounts_page.dart';

class HospitalDetailsArguments {
  HospitalDetailsArguments({required this.providerBloc});

  final ProviderBloc providerBloc;
}

class HospitalDetailsScreen extends StatelessWidget {
  const HospitalDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.providerBloc.state.provider;

    return Container(
      color: AppColors.white,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: SafeArea(
          child: Scaffold(
            appBar: HealthAppBar(backNavigation: true),
            backgroundColor: AppColors.white,
            body: _buildBody(),
            bottomNavigationBar: _buildActionButtons(provider),
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return HealthTabBar(
      tabs: [
        HealthTabItem(label: 'button.center_information'.tr()),
        HealthTabItem(label: 'button.discounts'.tr()),
      ],
      pages: const [
        HealthTabPageItem(body: CenterInformationPage()),
        HealthTabPageItem(body: DiscountsPage()),
      ],
    ).withPadding(0.0, 8.0, 0.0, 0.0);
  }

  Widget _buildActionButtons(Provider provider) {
    return Row(
      children: [
        Expanded(
          child: HealthFlatIconButton(
            onPressed: () {
              UrlLauncher.phoneTo(provider.phoneNumber);
            },
            backgroundColor: AppColors.skyBlue,
            icon: SvgPicture.asset(AppResources.phone),
          ),
        ),
        Expanded(
          child: HealthFlatIconButton(
            onPressed: () {
              UrlLauncher.mailTo(provider.email);
            },
            backgroundColor: AppColors.purple,
            icon: SvgPicture.asset(AppResources.mail),
          ),
        ),
        Expanded(
          child: HealthFlatIconButton(
            onPressed: () {
              UrlLauncher.whatsappTo(provider.phoneNumber);
            },
            backgroundColor: AppColors.lightGreen,
            icon: SvgPicture.asset(AppResources.whatsapp),
          ),
        ),
      ],
    );
  }
}
