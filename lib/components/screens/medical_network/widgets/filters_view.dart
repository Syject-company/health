import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_plus/app_colors.dart';
import 'package:health_plus/components/screens/medical_network/bloc/medical_network/medical_network_bloc.dart';
import 'package:health_plus/components/shared_widgets/separated_row.dart';
import 'package:health_plus/extensions/single_child_scroll_view.dart';
import 'package:health_plus/extensions/string.dart';
import 'package:health_plus/model/category.dart';
import 'package:health_plus/utils/disallow_glow.dart';
import 'package:health_plus/utils/elevation.dart';

class FiltersView extends StatefulWidget {
  const FiltersView({
    Key? key,
    this.insetPadding = EdgeInsets.zero,
  }) : super(key: key);

  final EdgeInsets insetPadding;

  @override
  State<FiltersView> createState() => _FiltersViewState();
}

class _FiltersViewState extends State<FiltersView> {
  final ScrollController _scrollController = ScrollController();
  final Map<Category, BuildContext> _categoriesWidgets = {};

  late BuildContext _scrollViewContext;
  late SingleChildScrollView _scrollView;

  @override
  Widget build(BuildContext context) {
    EasyLocalization.of(context)?.locale;

    return BlocConsumer<MedicalNetworkBloc, MedicalNetworkState>(
      listener: (_, state) {
        WidgetsBinding.instance?.addPostFrameCallback((_) {
          _scrollView.scrollToWidget(
            _scrollViewContext,
            _categoriesWidgets[state.selectedCategory]!,
          );
        });
      },
      builder: (_, state) {
        if (state.categoriesStatus == CategoriesStatus.fetching) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.purple,
            ),
          );
        }

        return SizedBox(
          height: widget.insetPadding.vertical + 52.0,
          child: DisallowGlow(
            child: Builder(
              builder: (context) {
                _scrollViewContext = context;

                return _scrollView = SingleChildScrollView(
                  padding: widget.insetPadding,
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  clipBehavior: Clip.none,
                  child: SeparatedRow(
                    separator: const SizedBox(width: 16.0),
                    children: state.categories.map((category) {
                      return Builder(
                        key: ValueKey(category),
                        builder: (childContext) {
                          WidgetsBinding.instance?.addPostFrameCallback((_) {
                            _categoriesWidgets[category] = childContext;
                          });

                          return _FilterButton(
                            onPressed: () {
                              childContext.medicalNetworkBloc
                                  .selectCategory(category);
                            },
                            selected: category == state.selectedCategory,
                            label: category.name,
                          );
                        },
                      );
                    }).toList(growable: false),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class _FilterButton extends StatelessWidget {
  const _FilterButton({
    Key? key,
    required this.onPressed,
    required this.label,
    required this.selected,
  }) : super(key: key);

  final VoidCallback onPressed;
  final String label;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Elevation(
      color: AppColors.black.withOpacity(0.05),
      offset: const Offset(0.0, 3.0),
      blurRadius: 6.0,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          primary: selected ? AppColors.white : AppColors.purple,
          backgroundColor: selected ? AppColors.purple : AppColors.white,
          padding: const EdgeInsets.fromLTRB(21.0, 12.0, 21.0, 12.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          minimumSize: const Size(0.0, 52.0),
          maximumSize: const Size(double.infinity, 52.0),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: Text(
          label.capitalize(),
          style: TextStyle(
            fontSize: 14.0,
            fontFamily: 'Almarai',
            fontWeight: FontWeight.w400,
            color: selected ? AppColors.white : AppColors.black,
          ),
        ),
      ),
    );
  }
}
