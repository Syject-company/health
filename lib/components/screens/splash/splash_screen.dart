import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:health_plus/app_colors.dart';
import 'package:health_plus/app_resources.dart';
import 'package:health_plus/extensions/sizer.dart';
import 'package:health_plus/router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    Key? key,
    required this.navigateAfter,
  }) : super(key: key);

  final String navigateAfter;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 1), () {
      rootNavigator.pushReplacementNamed(widget.navigateAfter);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ResponsiveLayout.setMediaQuery(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: AppColors.white,
            body: _buildBody(),
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Center(
      child: SvgPicture.asset(AppResources.logoWithLabelColored),
    );
  }
}
