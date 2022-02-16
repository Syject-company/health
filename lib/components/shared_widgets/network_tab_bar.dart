import 'package:flutter/material.dart';
import 'package:health_plus/app_colors.dart';
import 'package:health_plus/components/shared_widgets/separated_row.dart';

class NetworkTabItem {
  const NetworkTabItem({required this.label});

  final String label;
}

class NetworkTabPageItem {
  const NetworkTabPageItem({required this.body});

  final Widget body;
}

class NetworkTabBar extends StatefulWidget {
  const NetworkTabBar({
    Key? key,
    required this.tabs,
    required this.pages,
  }) : super(key: key);

  final List<NetworkTabItem> tabs;
  final List<NetworkTabPageItem> pages;

  @override
  _NetworkTabBarState createState() => _NetworkTabBarState();
}

class _NetworkTabBarState extends State<NetworkTabBar> {
  int selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildTabs(),
        const SizedBox(height: 24.0),
        widget.pages[selectedTabIndex].body,
      ],
    );
  }

  Widget _buildTabs() {
    return Container(
      height: 50.0,
      margin: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 0.0,
      ),
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0.0, 3.0),
            blurRadius: 6.0,
          ),
        ],
      ),
      child: SeparatedRow(
        separator: const SizedBox(width: 5.0),
        children: widget.tabs
            .asMap()
            .map((index, tab) {
              return MapEntry(
                index,
                Expanded(
                  child: _NetworkTab(
                    onPressed: () {
                      setState(() => selectedTabIndex = index);
                    },
                    selected: index == selectedTabIndex,
                    label: tab.label,
                  ),
                ),
              );
            })
            .values
            .toList(),
      ),
    );
  }
}

class _NetworkTab extends StatelessWidget {
  const _NetworkTab({
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
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        primary: selected ? AppColors.white : AppColors.purple,
        minimumSize: Size.infinite,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        backgroundColor: selected ? AppColors.purple : AppColors.transparent,
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 14.0,
          fontFamily: 'Almarai',
          fontWeight: FontWeight.w400,
          color: selected ? AppColors.white : AppColors.purpleLightGrey,
        ),
      ),
    );
  }
}
