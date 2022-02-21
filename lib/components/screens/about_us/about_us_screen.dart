import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:health_plus/app_colors.dart';
import 'package:health_plus/app_resources.dart';
import 'package:health_plus/components/shared_widgets/app_bar/health_app_bar.dart';
import 'package:health_plus/components/shared_widgets/separated_column.dart';
import 'package:health_plus/extensions/string.dart';
import 'package:health_plus/model/static_page.dart';

import 'bloc/about_us_bloc.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: AppColors.white,
            appBar: HealthAppBar(backNavigation: true),
            body: _buildBody(),
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return SizedBox.expand(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16.0, 64.0, 16.0, 32.0),
        child: Column(
          children: [
            _buildLogo(),
            const SizedBox(height: 48.0),
            _buildPages(),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return SvgPicture.asset(AppResources.logoWithLabelColored);
  }

  Widget _buildPages() {
    return BlocBuilder<AboutUsBloc, AboutUsState>(
      builder: (_, state) {
        return SeparatedColumn(
          separator: const SizedBox(height: 18.0),
          children: state.pages.map((page) {
            return _buildPageItem(page);
          }).toList(),
        );
      },
    );
  }

  Widget _buildPageItem(StaticPage page) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          page.title.capitalize(),
          style: const TextStyle(
            height: 1.57,
            fontSize: 20.0,
            fontWeight: FontWeight.w700,
            color: AppColors.purpleDarkGrey,
          ),
        ),
        const SizedBox(height: 18.0),
        Text(
          page.content.capitalize(),
          style: const TextStyle(
            height: 1.57,
            fontSize: 14.0,
            fontFamily: 'Almarai',
            fontWeight: FontWeight.w400,
            color: AppColors.grey,
          ),
        ),
      ],
    );
  }
}
