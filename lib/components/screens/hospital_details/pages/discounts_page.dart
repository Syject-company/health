import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:health_plus/app_colors.dart';
import 'package:health_plus/app_resources.dart';
import 'package:health_plus/components/screens/medical_network/bloc/provider/provider_bloc.dart';
import 'package:health_plus/components/shared_widgets/health_card.dart';
import 'package:health_plus/model/promotion.dart';

class DiscountsPage extends StatelessWidget {
  const DiscountsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.providerBloc.state.provider;
    final promotions = provider.promotions;

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      itemBuilder: (_, index) {
        return _buildDiscountCard(promotions[index]);
      },
      separatorBuilder: (_, __) {
        return const SizedBox(height: 16.0);
      },
      itemCount: promotions.length,
    );
  }

  Widget _buildDiscountCard(Promotion promotion) {
    return HealthCard(
      padding: const EdgeInsets.fromLTRB(18.0, 16.0, 18.0, 16.0),
      borderRadius: 10.0,
      child: Row(
        children: [
          SvgPicture.asset(AppResources.discount),
          const SizedBox(width: 8.0),
          Text(
            promotion.description,
            style: const TextStyle(
              fontSize: 16.0,
              fontFamily: 'Almarai',
              fontWeight: FontWeight.w400,
              color: AppColors.black,
            ),
          ),
          const Spacer(),
          Text(
            '${promotion.amount} %',
            style: const TextStyle(
              fontSize: 16.0,
              fontFamily: 'Almarai',
              fontWeight: FontWeight.w700,
              color: AppColors.purple,
            ),
          ),
        ],
      ),
    );
  }
}
