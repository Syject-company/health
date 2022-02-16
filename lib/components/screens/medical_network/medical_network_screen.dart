import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:health_plus/app_colors.dart';
import 'package:health_plus/app_resources.dart';
import 'package:health_plus/extensions/widget.dart';
import 'package:health_plus/utils/elevation.dart';
import 'package:health_plus/utils/keep_alive.dart';

import 'bloc/medical_network/medical_network_bloc.dart';
import 'pages/medical_network_list_page.dart';
import 'pages/medical_network_map_page.dart';

class MedicalNetworkScreen extends StatelessWidget {
  MedicalNetworkScreen({Key? key}) : super(key: key);

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<MedicalNetworkBloc, MedicalNetworkState>(
      listener: (_, state) {
        _pageController
            .jumpToPage(state.view == MedicalNetworkView.list ? 0 : 1);
      },
      child: Stack(
        children: [
          _buildViewPages(),
          _buildToggleViewButton(context),
        ],
      ),
    );
  }

  Widget _buildViewPages() {
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: _pageController,
      children: [
        KeepAliveChild(child: MedicalNetworkListPage()),
        const KeepAliveChild(child: MedicalNetworkMapPage()),
      ],
    );
  }

  Widget _buildToggleViewButton(BuildContext context) {
    EasyLocalization.of(context)?.locale;

    return BlocSelector<MedicalNetworkBloc, MedicalNetworkState,
        MedicalNetworkView>(
      selector: (state) => state.view,
      builder: (context, view) {
        final text = view == MedicalNetworkView.map
            ? 'button.show_as_list'
            : 'button.show_on_map';
        final icon = view == MedicalNetworkView.map
            ? AppResources.listView
            : AppResources.mapView;

        return Align(
          alignment: Alignment.bottomCenter,
          child: Elevation(
            color: AppColors.purple.withOpacity(0.20),
            offset: const Offset(0.0, 9.0),
            blurRadius: 20.0,
            child: TextButton(
              onPressed: context.medicalNetworkBloc.toggleView,
              style: TextButton.styleFrom(
                primary: AppColors.white,
                backgroundColor: AppColors.purple,
                padding: const EdgeInsets.symmetric(
                  horizontal: 21.0,
                  vertical: 12.0,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(13.0),
                ),
                minimumSize: const Size(0.0, 54.0),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(icon),
                  const SizedBox(width: 8.0),
                  Text(
                    text.tr(),
                    style: const TextStyle(
                      fontSize: 14.0,
                      fontFamily: 'Almarai',
                      fontWeight: FontWeight.w400,
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
            ).withPaddingAll(16.0),
          ),
        );
      },
    );
  }
}
