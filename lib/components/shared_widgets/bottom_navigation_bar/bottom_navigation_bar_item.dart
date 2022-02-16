part of 'bottom_navigation_bar.dart';

class HealthBottomNavigationBarItem {
  const HealthBottomNavigationBarItem({
    this.onPressed,
    required this.iconPath,
    required this.labelText,
    this.enabled = true,
  });

  final VoidCallback? onPressed;
  final String iconPath;
  final String labelText;
  final bool enabled;
}
