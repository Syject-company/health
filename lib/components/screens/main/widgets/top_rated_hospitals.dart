import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:health_plus/app_colors.dart';
import 'package:health_plus/app_resources.dart';
import 'package:health_plus/components/screens/home/bloc/page_navigator_bloc.dart';
import 'package:health_plus/components/screens/hospital_details/hospital_details_screen.dart';
import 'package:health_plus/components/screens/medical_network/bloc/medical_network/medical_network_bloc.dart';
import 'package:health_plus/components/screens/medical_network/bloc/provider/provider_bloc.dart';
import 'package:health_plus/components/shared_widgets/health_card.dart';
import 'package:health_plus/components/shared_widgets/health_hospital_icon.dart';
import 'package:health_plus/extensions/box_scroll_view.dart';
import 'package:health_plus/extensions/widget.dart';
import 'package:health_plus/model/provider.dart';
import 'package:health_plus/router.dart';
import 'package:health_plus/utils/disallow_glow.dart';
import 'package:health_plus/utils/tuple.dart';

class TopRatedHospitals extends StatelessWidget {
  TopRatedHospitals({Key? key}) : super(key: key);

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildTitle(),
            _buildSeeAllButton(context),
          ],
        ).withPaddingSymmetric(16.0, 0.0),
        const SizedBox(height: 24.0),
        _buildProviders(),
      ],
    );
  }

  Widget _buildTitle() {
    return Text(
      'text.top_rated_hospitals'.tr(),
      style: const TextStyle(
        fontSize: 16.0,
        fontFamily: 'Almarai',
        fontWeight: FontWeight.w700,
        color: AppColors.black,
      ),
    );
  }

  Widget _buildSeeAllButton(BuildContext context) {
    return GestureDetector(
      onTap: Feedback.wrapForTap(
        () {
          context.medicalNetworkBloc.selectDefaultCategory();
          context.pageNavigatorBloc.navigateTo(HomePage.medicalNetwork.value);
        },
        context,
      ),
      child: Text(
        'button.see_all'.tr(),
        style: const TextStyle(
          fontSize: 14.0,
          fontFamily: 'Almarai',
          fontWeight: FontWeight.w700,
          decoration: TextDecoration.underline,
          color: AppColors.purple,
        ),
      ),
    );
  }

  Widget _buildProviders() {
    return BlocSelector<MedicalNetworkBloc, MedicalNetworkState,
        Tuple2<ProvidersStatus, List<Provider>>>(
      selector: (state) => Tuple2(state.providersStatus, state.providers),
      builder: (_, state) {
        final providersStatus = state.item1;

        if (providersStatus == ProvidersStatus.fetching) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.purple,
            ),
          );
        }

        final providers = state.item2;
        // final ratedProviders = providers.where((provider) {
        //   return provider.rating >= 4.5;
        // }).toList(growable: false);

        return SizedBox(
          height: 186.0,
          child: DisallowGlow(
            child: Builder(
              builder: (context) {
                late ListView listView;

                return listView = ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  clipBehavior: Clip.none,
                  itemBuilder: (_, index) {
                    final provider = providers[index];

                    return Builder(
                      key: ValueKey(provider),
                      builder: (childContext) {
                        return BlocProvider(
                          create: (_) => ProviderBloc(provider: provider),
                          child: _HospitalCard(
                            onPressed: () {
                              listView.scrollToWidget(context, childContext);
                            },
                          ),
                        );
                      },
                    );
                  },
                  separatorBuilder: (_, __) {
                    return const SizedBox(width: 16.0);
                  },
                  itemCount: providers.length,
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class _HospitalCard extends StatelessWidget {
  const _HospitalCard({
    Key? key,
    this.onPressed,
  }) : super(key: key);

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final provider = context.providerBloc.state.provider;

    return HealthCard(
      onPressed: () {
        rootNavigator.pushNamed(
          RootRoutes.hospitalDetails,
          arguments: HospitalDetailsArguments(
            providerBloc: context.providerBloc,
          ),
        );
        onPressed?.call();
      },
      padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 18.0),
      width: 254,
      height: 186,
      borderRadius: 10.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: CachedNetworkImage(
                  imageUrl: 'https://universum.clinic/all-images/all/0011.jpg',
                  fit: BoxFit.cover,
                  height: 106.0,
                ),
              ),
              PositionedDirectional(
                end: 12.0,
                bottom: -29.0,
                width: 58,
                height: 58,
                child: HealthHospitalIcon(
                  borderWidth: 2.0,
                  borderRadius: 9.0,
                  imageUrl: provider.logo,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12.0),
          _buildName(provider),
          const SizedBox(height: 8.0),
          _buildGeoLocation(),
        ],
      ),
    );
  }

  Widget _buildName(Provider provider) {
    return Text(
      provider.name,
      maxLines: 1,
      softWrap: false,
      style: const TextStyle(
        fontSize: 14.0,
        fontFamily: 'Almarai',
        fontWeight: FontWeight.w400,
        overflow: TextOverflow.fade,
        color: AppColors.purple,
      ),
    ).withPadding(14.0, 0.0, 84.0, 0.0);
  }

  Widget _buildGeoLocation() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SvgPicture.asset(
          AppResources.geoPin,
          color: AppColors.lightGrey,
          width: 12.0,
        ),
        const SizedBox(width: 6.0),
        const Text(
          'provider.location',
          maxLines: 1,
          softWrap: false,
          style: TextStyle(
            fontSize: 12.0,
            fontFamily: 'Almarai',
            fontWeight: FontWeight.w400,
            overflow: TextOverflow.fade,
            color: AppColors.lightGrey,
          ),
        ),
      ],
    ).withPaddingSymmetric(14.0, 0.0);
  }
}
