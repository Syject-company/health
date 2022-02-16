import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_plus/app_colors.dart';
import 'package:health_plus/components/screens/medical_network/bloc/provider/provider_bloc.dart';
import 'package:health_plus/extensions/box_scroll_view.dart';
import 'package:health_plus/extensions/widget.dart';
import 'package:health_plus/model/provider.dart';
import 'package:health_plus/utils/tuple.dart';

import 'bloc/favourites_bloc.dart';
import 'widgets/hospital_card.dart';

class FavouritesScreen extends StatelessWidget {
  FavouritesScreen({Key? key}) : super(key: key);

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitle(),
        const SizedBox(height: 24.0),
        BlocSelector<FavouritesBloc, FavouritesState,
            Tuple2<FavouritesStatus, List<Provider>>>(
          selector: (state) => Tuple2(state.status, state.providers),
          builder: (_, state) {
            final favouritesStatus = state.item1;

            if (favouritesStatus == FavouritesStatus.fetching) {
              return const Expanded(
                child: Center(
                  child: CircularProgressIndicator(
                    color: AppColors.purple,
                  ),
                ),
              );
            }

            final providers = state.item2;

            if (providers.isEmpty) {
              return Expanded(
                child: Center(
                  child: const Text(
                    'There are no favourites associated with this account',
                    style: TextStyle(
                      height: 1.33,
                      fontSize: 18.0,
                      fontFamily: 'Almarai',
                      fontWeight: FontWeight.w700,
                      color: AppColors.purpleDarkGrey,
                    ),
                    textAlign: TextAlign.center,
                  ).withPaddingSymmetric(16.0, 0.0),
                ),
              );
            }

            return Expanded(
              child: Builder(
                builder: (context) {
                  late ListView listView;

                  return listView = ListView.separated(
                    padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
                    controller: _scrollController,
                    itemBuilder: (_, index) {
                      final provider = providers[index];

                      return Builder(
                        key: ValueKey(provider),
                        builder: (childContext) {
                          return BlocProvider(
                            create: (context) =>
                                ProviderBloc(provider: provider),
                            child: HospitalCard(
                              onPressed: () {
                                listView.scrollToWidget(context, childContext);
                              },
                            ),
                          );
                        },
                      );
                    },
                    separatorBuilder: (_, __) {
                      return const SizedBox(height: 16.0);
                    },
                    itemCount: providers.length,
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildTitle() {
    return Text(
      'text.favourites'.tr(),
      style: const TextStyle(
        fontSize: 28.0,
        fontFamily: 'Almarai',
        fontWeight: FontWeight.w700,
        color: AppColors.purpleDarkGrey,
      ),
    ).withPadding(16.0, 8.0, 16.0, 0.0);
  }
}
