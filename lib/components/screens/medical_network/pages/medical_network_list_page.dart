import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:health_plus/app_colors.dart';
import 'package:health_plus/app_resources.dart';
import 'package:health_plus/components/screens/medical_network/bloc/medical_network/medical_network_bloc.dart';
import 'package:health_plus/components/screens/medical_network/bloc/provider/provider_bloc.dart';
import 'package:health_plus/components/screens/medical_network/widgets/filters_view.dart';
import 'package:health_plus/components/shared_widgets/health_icon_button.dart';
import 'package:health_plus/components/shared_widgets/health_search_input.dart';
import 'package:health_plus/extensions/box_scroll_view.dart';
import 'package:health_plus/extensions/widget.dart';
import 'package:health_plus/model/provider.dart';
import 'package:health_plus/utils/elevation.dart';

import '../widgets/hospital_card.dart';

class MedicalNetworkListPage extends StatelessWidget {
  MedicalNetworkListPage({Key? key}) : super(key: key);

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    EasyLocalization.of(context)?.locale;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitle(),
        const SizedBox(height: 24.0),
        _buildSearch(),
        const SizedBox(height: 18.0),
        _buildProviders(),
      ],
    );
  }

  Widget _buildTitle() {
    return Text(
      'text.medical_network'.tr(),
      style: const TextStyle(
        fontSize: 28.0,
        fontFamily: 'Almarai',
        fontWeight: FontWeight.w700,
        color: AppColors.purpleDarkGrey,
      ),
    ).withPadding(16.0, 8.0, 16.0, 0.0);
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

  Widget _buildProviders() {
    return BlocSelector<MedicalNetworkBloc, MedicalNetworkState,
        List<Provider>>(
      selector: (state) => state.filteredProviders,
      builder: (_, filteredProviders) {
        return Expanded(
          child: Column(
            children: [
              const Align(
                alignment: AlignmentDirectional.topStart,
                child: FiltersView(
                  insetPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
                ),
              ),
              const SizedBox(height: 18.0),
              Expanded(
                child: Builder(
                  builder: (context) {
                    late ListView listView;

                    return listView = ListView.separated(
                      padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
                      controller: _scrollController,
                      itemBuilder: (_, index) {
                        final provider = filteredProviders[index];

                        return Builder(
                          key: ValueKey(provider),
                          builder: (childContext) {
                            return BlocProvider(
                              create: (_) => ProviderBloc(provider: provider),
                              child: HospitalCard(
                                onPressed: () {
                                  listView.scrollToWidget(
                                      context, childContext);
                                },
                              ),
                            );
                          },
                        );
                      },
                      separatorBuilder: (_, __) {
                        return const SizedBox(height: 16.0);
                      },
                      itemCount: filteredProviders.length,
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
