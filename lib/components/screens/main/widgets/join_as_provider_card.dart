import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_plus/app_colors.dart';
import 'package:health_plus/app_resources.dart';
import 'package:health_plus/components/shared_widgets/health_card.dart';
import 'package:health_plus/components/shared_widgets/health_outlined_button.dart';
import 'package:health_plus/extensions/widget.dart';

class JoinAsProviderCard extends StatelessWidget {
  const JoinAsProviderCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HealthCard(
      padding: const EdgeInsets.symmetric(
        horizontal: 32.0,
        vertical: 12.0,
      ),
      borderRadius: 21.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'text.join_as_provider'.tr(),
                  style: const TextStyle(
                    height: 1.5,
                    fontSize: 21.0,
                    fontFamily: 'Almarai',
                    fontWeight: FontWeight.w700,
                    color: AppColors.black,
                  ),
                ),
                const SizedBox(height: 16.0),
                HealthOutlinedButton(
                  onPressed: () {},
                  height: 38.0,
                  color: AppColors.purple,
                  child: Text(
                    'button.start_now'.tr(),
                    style: const TextStyle(
                      fontSize: 13.0,
                      fontFamily: 'Almarai',
                      fontWeight: FontWeight.w700,
                      color: AppColors.purple,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 24.0),
          Image.asset(
            AppResources.startAsProvider,
            width: 104.0,
          ),
        ],
      ),
    ).withPaddingSymmetric(16.0, 0.0);
  }
}
