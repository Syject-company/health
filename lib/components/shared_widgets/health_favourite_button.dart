import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:health_plus/app_colors.dart';
import 'package:health_plus/app_resources.dart';
import 'package:health_plus/components/screens/favourites/bloc/favourites_bloc.dart';
import 'package:health_plus/components/screens/medical_network/bloc/provider/provider_bloc.dart';

class HealthFavouriteButton extends StatelessWidget {
  const HealthFavouriteButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.providerBloc.state.provider;

    return TextButton(
      onPressed: () {
        context.favouritesBloc.contains(provider)
            ? context.favouritesBloc.removeFromFavourites(provider)
            : context.favouritesBloc.addToFavourites(provider);
      },
      style: TextButton.styleFrom(
        primary: AppColors.white,
        backgroundColor: AppColors.powderBlue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: const BorderSide(
            color: AppColors.white,
            width: 2.0,
          ),
        ),
        fixedSize: const Size(38.0, 38.0),
        minimumSize: const Size(38.0, 38.0),
        maximumSize: const Size(38.0, 38.0),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: BlocBuilder<FavouritesBloc, FavouritesState>(
        builder: (_, __) {
          return SvgPicture.asset(
            context.favouritesBloc.contains(provider)
                ? AppResources.favouriteChecked
                : AppResources.favourite,
          );
        },
      ),
    );
  }
}
