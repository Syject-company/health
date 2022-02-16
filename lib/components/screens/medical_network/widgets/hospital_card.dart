import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:health_plus/app_colors.dart';
import 'package:health_plus/app_resources.dart';
import 'package:health_plus/components/screens/hospital_details/hospital_details_screen.dart';
import 'package:health_plus/components/screens/medical_network/bloc/provider/provider_bloc.dart';
import 'package:health_plus/components/screens/my_account/bloc/account_bloc.dart';
import 'package:health_plus/components/shared_widgets/health_card.dart';
import 'package:health_plus/components/shared_widgets/health_favourite_button.dart';
import 'package:health_plus/components/shared_widgets/health_hospital_icon.dart';
import 'package:health_plus/extensions/widget.dart';
import 'package:health_plus/model/provider.dart';
import 'package:health_plus/router.dart';

class HospitalCard extends StatelessWidget {
  const HospitalCard({
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
                  width: double.infinity,
                  height: 142.0,
                ),
              ),
              BlocSelector<AccountBloc, AccountState, UserRole>(
                selector: (state) => state.role,
                builder: (_, userRole) {
                  if (userRole == UserRole.user) {
                    return const PositionedDirectional(
                      top: 12.0,
                      end: 12.0,
                      child: HealthFavouriteButton(),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
              PositionedDirectional(
                end: 12.0,
                bottom: -40.0,
                child: HealthHospitalIcon(
                  imageUrl: provider.logo,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12.0),
          _buildName(provider),
          const SizedBox(height: 16.0),
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
        height: 1.5,
        fontSize: 16.0,
        fontFamily: 'Almarai',
        fontWeight: FontWeight.w400,
        overflow: TextOverflow.fade,
        color: AppColors.purple,
      ),
    ).withPadding(14.0, 0.0, 106.0, 0.0);
  }

  Widget _buildGeoLocation() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SvgPicture.asset(
          AppResources.geoPin,
          color: AppColors.lightGrey,
        ),
        const SizedBox(width: 12.0),
        const Text(
          'provider.location',
          maxLines: 1,
          softWrap: false,
          style: TextStyle(
            fontSize: 14.0,
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
