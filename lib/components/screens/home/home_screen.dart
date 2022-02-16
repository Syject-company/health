import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_plus/app_colors.dart';
import 'package:health_plus/app_resources.dart';
import 'package:health_plus/components/screens/favourites/favourites_screen.dart';
import 'package:health_plus/components/screens/home/bloc/page_navigator_bloc.dart';
import 'package:health_plus/components/screens/main/main_screen.dart';
import 'package:health_plus/components/screens/medical_network/medical_network_screen.dart';
import 'package:health_plus/components/screens/my_account/bloc/account_bloc.dart';
import 'package:health_plus/components/screens/my_account/my_account_screen.dart';
import 'package:health_plus/components/screens/offers/offers_screen.dart';
import 'package:health_plus/components/shared_widgets/app_bar/health_app_bar.dart';
import 'package:health_plus/components/shared_widgets/bottom_navigation_bar/bottom_navigation_bar.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<PageNavigatorBloc, PageNavigatorState>(
      listener: (_, state) {
        _pageController.jumpToPage(state.page);
      },
      child: Container(
        color: AppColors.white,
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.dark,
          child: SafeArea(
            child: Scaffold(
              backgroundColor: AppColors.white,
              appBar: HealthAppBar(),
              body: _buildBody(),
              bottomNavigationBar: _buildBottomNavigationBar(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: _pageController,
      children: [
        const MainScreen(),
        MedicalNetworkScreen(),
        const OffersScreen(),
        FavouritesScreen(),
        const MyAccountScreen(),
      ],
    );
  }

  Widget _buildBottomNavigationBar() {
    return BlocSelector<AccountBloc, AccountState, UserRole>(
      selector: (state) => state.role,
      builder: (_, role) {
        return HealthBottomNavigationBar(
          items: [
            const HealthBottomNavigationBarItem(
              iconPath: AppResources.home,
              labelText: 'button.home',
            ),
            const HealthBottomNavigationBarItem(
              iconPath: AppResources.medicalNetwork,
              labelText: 'button.medical_network',
            ),
            HealthBottomNavigationBarItem(
              iconPath: AppResources.offers,
              labelText: 'button.offers',
              enabled: role == UserRole.user,
            ),
            HealthBottomNavigationBarItem(
              iconPath: AppResources.favourites,
              labelText: 'button.favourites',
              enabled: role == UserRole.user,
            ),
            const HealthBottomNavigationBarItem(
              iconPath: AppResources.myAccount,
              labelText: 'button.my_account',
            ),
          ],
        );
      },
    );
  }
}
