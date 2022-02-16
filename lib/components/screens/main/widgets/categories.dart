import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_plus/app_colors.dart';
import 'package:health_plus/components/screens/home/bloc/page_navigator_bloc.dart';
import 'package:health_plus/components/screens/medical_network/bloc/medical_network/medical_network_bloc.dart';
import 'package:health_plus/components/shared_widgets/health_card.dart';
import 'package:health_plus/extensions/box_scroll_view.dart';
import 'package:health_plus/extensions/string.dart';
import 'package:health_plus/extensions/widget.dart';
import 'package:health_plus/model/category.dart';
import 'package:health_plus/utils/disallow_glow.dart';
import 'package:health_plus/utils/tuple.dart';

class Categories extends StatelessWidget {
  Categories({Key? key}) : super(key: key);

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'text.we_can_help_you_find'.tr(),
          style: const TextStyle(
            fontSize: 16.0,
            fontFamily: 'Almarai',
            fontWeight: FontWeight.w700,
            color: AppColors.black,
          ),
        ).withPaddingSymmetric(16.0, 0.0),
        const SizedBox(height: 20.0),
        _buildCategories(),
      ],
    );
  }

  Widget _buildCategories() {
    return BlocSelector<MedicalNetworkBloc, MedicalNetworkState,
        Tuple2<CategoriesStatus, List<Category>>>(
      selector: (state) => Tuple2(state.categoriesStatus, state.categories),
      builder: (_, state) {
        final categoriesStatus = state.item1;

        if (categoriesStatus == CategoriesStatus.fetching) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.purple,
            ),
          );
        }

        final categories = state.item2.isNotEmpty ? state.item2.sublist(1) : [];

        return SizedBox(
          height: 152.0,
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
                    final category = categories[index];

                    return Builder(
                      key: ValueKey(category),
                      builder: (childContext) {
                        return _buildCategoryCard(
                          onPressed: () {
                            context.medicalNetworkBloc.selectCategory(category);
                            context.pageNavigatorBloc
                                .navigateTo(HomePage.medicalNetwork.value);
                            listView.scrollToWidget(context, childContext);
                          },
                          category: category,
                        );
                      },
                    );
                  },
                  separatorBuilder: (_, __) {
                    return const SizedBox(width: 16.0);
                  },
                  itemCount: categories.length,
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildCategoryCard({
    required VoidCallback onPressed,
    required Category category,
  }) {
    return HealthCard(
      onPressed: onPressed,
      width: 136.0,
      height: 152.0,
      borderRadius: 12.0,
      child: Column(
        children: [
          category.image != null
              ? CachedNetworkImage(
                  imageUrl: category.image!,
                  fit: BoxFit.cover,
                  height: 100.0,
                )
              : const SizedBox(height: 100.0),
          Expanded(
            child: Center(
              child: Text(
                category.name.capitalize(),
                style: const TextStyle(
                  fontSize: 14.0,
                  fontFamily: 'Almarai',
                  fontWeight: FontWeight.w400,
                  color: AppColors.purple,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
