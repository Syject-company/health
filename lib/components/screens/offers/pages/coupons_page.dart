import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_plus/app_colors.dart';
import 'package:health_plus/app_resources.dart';
import 'package:health_plus/components/screens/offers/bloc/offers_bloc.dart';
import 'package:health_plus/components/shared_widgets/health_card.dart';
import 'package:health_plus/extensions/box_scroll_view.dart';
import 'package:health_plus/extensions/widget.dart';
import 'package:health_plus/model/promotion.dart';
import 'package:health_plus/utils/tuple.dart';

class CouponsPage extends StatelessWidget {
  CouponsPage({Key? key}) : super(key: key);

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<OffersBloc, OffersState,
        Tuple2<OffersStatus, List<Promotion>>>(
      selector: (state) => Tuple2(state.status, state.promotions),
      builder: (_, state) {
        final offersStatus = state.item1;

        if (offersStatus == OffersStatus.fetching) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.purple,
            ),
          );
        }

        final promotions = state.item2;

        return Builder(builder: (context) {
          late ListView listView;

          return listView = ListView.separated(
            padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
            controller: _scrollController,
            itemBuilder: (_, index) {
              final promotion = promotions[index];

              return Builder(
                key: ValueKey(promotion),
                builder: (childContext) {
                  return _CouponCard(
                    onPressed: () {
                      listView.scrollToWidget(context, childContext);
                    },
                    promotion: promotion,
                    dark: index.isEven,
                  );
                },
              );
            },
            separatorBuilder: (_, __) {
              return const SizedBox(height: 16.0);
            },
            itemCount: promotions.length,
          );
        });
      },
    );
  }
}

class _CouponCard extends StatelessWidget {
  const _CouponCard({
    Key? key,
    required this.promotion,
    this.onPressed,
    this.dark = true,
  }) : super(key: key);

  final Promotion promotion;
  final VoidCallback? onPressed;
  final bool dark;

  @override
  Widget build(BuildContext context) {
    return HealthCard(
      onPressed: onPressed,
      padding: const EdgeInsets.all(10.0),
      height: 248.0,
      borderRadius: 10.0,
      child: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: [
          _buildBackgroundImage(),
          _buildBackgroundGradient(context, dark),
          _buildTitle(),
          _buildDiscountLabel(),
          _buildHospitalIcon(),
        ],
      ),
    );
  }

  Widget _buildBackgroundImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: promotion.image != null
          ? CachedNetworkImage(
              imageUrl: promotion.image!,
              fit: BoxFit.cover,
            )
          : const SizedBox.shrink(),
    );
  }

  Widget _buildBackgroundGradient(
    BuildContext context,
    bool dark,
  ) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        gradient: LinearGradient(
          colors:
              dark ? AppColors.cardPurpleGradient : AppColors.cardBlueGradient,
          begin: AlignmentDirectional.centerEnd
              .resolve(Directionality.of(context)),
          end: AlignmentDirectional.centerStart
              .resolve(Directionality.of(context)),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          promotion.name,
          style: const TextStyle(
            fontSize: 28.0,
            fontFamily: 'Almarai',
            fontWeight: FontWeight.w700,
            color: AppColors.white,
          ),
        ),
        const SizedBox(height: 14.0),
        const Text(
          'Use and get\na discount',
          style: TextStyle(
            height: 1.5,
            fontSize: 20.0,
            fontFamily: 'Almarai',
            fontWeight: FontWeight.w700,
            color: AppColors.white,
          ),
        ),
      ],
    ).withPaddingAll(28.0);
  }

  Widget _buildDiscountLabel() {
    return PositionedDirectional(
      top: 12.0,
      end: 12.0,
      child: Container(
        width: 96.0,
        height: 96.0,
        decoration: const BoxDecoration(
          color: AppColors.purple,
          shape: BoxShape.circle,
        ),
        child: Center(
          widthFactor: 1,
          heightFactor: 1,
          child: AutoSizeText(
            '${promotion.amount}%',
            minFontSize: 24.0,
            style: const TextStyle(
              fontSize: 36,
              fontFamily: 'Almarai',
              fontWeight: FontWeight.w700,
              color: AppColors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget _buildHospitalIcon() {
    return PositionedDirectional(
      end: 12.0,
      bottom: 12.0,
      child: Container(
        width: 48.0,
        height: 48.0,
        padding: const EdgeInsets.all(2.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14.0),
          color: AppColors.white,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: Image.asset(AppResources.hospitalIcon),
        ),
      ),
    );
  }
}
