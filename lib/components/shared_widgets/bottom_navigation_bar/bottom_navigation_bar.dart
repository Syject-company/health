import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:health_plus/app_colors.dart';
import 'package:health_plus/app_constants.dart';
import 'package:health_plus/components/screens/home/bloc/page_navigator_bloc.dart';
import 'package:health_plus/components/shared_widgets/separated_row.dart';

part 'bottom_navigation_bar_item.dart';

typedef SelectCallback = void Function(int index);

const Color _selectedIconColor = AppColors.purple;
const Color _deselectedIconColor = AppColors.purpleLightGrey;
const Color _disabledIconColor = AppColors.purpleLight;

class HealthBottomNavigationBar extends StatelessWidget {
  const HealthBottomNavigationBar({
    Key? key,
    required this.items,
  }) : super(key: key);

  final List<HealthBottomNavigationBarItem> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppConstants.bottomNavigationBarHeight,
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0.0, 4.0),
            blurRadius: 15.0,
          ),
        ],
      ),
      child: _buildButtons(),
    );
  }

  Widget _buildButtons() {
    return BlocBuilder<PageNavigatorBloc, PageNavigatorState>(
      builder: (context, state) {
        return SeparatedRow(
          mainAxisAlignment: MainAxisAlignment.center,
          separator: const SizedBox(width: 8.0),
          children: items
              .asMap()
              .map((index, item) {
                return MapEntry(
                  index,
                  Flexible(
                    child: GestureDetector(
                      onTap: Feedback.wrapForTap(
                        item.enabled
                            ? () {
                                context.pageNavigatorBloc.navigateTo(index);
                                item.onPressed?.call();
                              }
                            : null,
                        context,
                      ),
                      child: _HealthBottomNavigationBarButton(
                        key: ValueKey(item),
                        iconPath: item.iconPath,
                        labelText: item.labelText,
                        selected: state.page == index,
                        enabled: item.enabled,
                      ),
                      behavior: HitTestBehavior.opaque,
                    ),
                  ),
                );
              })
              .values
              .toList(),
        );
      },
    );
  }
}

class _HealthBottomNavigationBarButton extends StatelessWidget {
  const _HealthBottomNavigationBarButton({
    Key? key,
    required this.iconPath,
    required this.labelText,
    required this.selected,
    required this.enabled,
  }) : super(key: key);

  final String iconPath;
  final String labelText;
  final bool selected;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (selected)
          Container(
            height: 3.0,
            margin: const EdgeInsets.symmetric(
              horizontal: 12.0,
              vertical: 0.0,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2.0),
              color: AppColors.purple,
            ),
          ),
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildIcon(),
              const SizedBox(height: 8.0),
              _buildLabel(),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildIcon() {
    return SvgPicture.asset(
      iconPath,
      color: _getColor(),
    );
  }

  Widget _buildLabel() {
    return Text(
      labelText.tr(),
      style: TextStyle(
        fontSize: 12.0,
        fontFamily: 'Almarai',
        fontWeight: FontWeight.w400,
        color: _getColor(),
      ),
      textAlign: TextAlign.center,
    );
  }

  Color _getColor() {
    if (enabled) {
      return selected ? _selectedIconColor : _deselectedIconColor;
    }
    return _disabledIconColor;
  }
}
