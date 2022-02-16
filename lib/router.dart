import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/screens/about_us/about_us_screen.dart';
import 'components/screens/change_password/bloc/change_password_bloc.dart';
import 'components/screens/change_password/change_password_screen.dart';
import 'components/screens/home/bloc/page_navigator_bloc.dart';
import 'components/screens/home/home_screen.dart';
import 'components/screens/hospital_details/hospital_details_screen.dart';
import 'components/screens/login/bloc/login_bloc.dart';
import 'components/screens/login/login_screen.dart';
import 'components/screens/my_account/bloc/account_bloc.dart';
import 'components/screens/my_package/my_package_screen.dart';
import 'components/screens/notifications/notifications_screen.dart';
import 'components/screens/onboarding/bloc/onboarding_bloc.dart';
import 'components/screens/onboarding/onboarding_screen.dart';
import 'components/screens/personal_data/bloc/personal_data_bloc.dart';
import 'components/screens/personal_data/personal_data_screen.dart';
import 'components/screens/plans/apply_plan/apply_plan_screen.dart';
import 'components/screens/plans/bloc/plans/plans_bloc.dart';
import 'components/screens/plans/plans_screen.dart';
import 'components/screens/privacy_policy/privacy_policy_screen.dart';
import 'components/screens/registration/bloc/registration_bloc.dart';
import 'components/screens/registration/registration_screen.dart';
import 'components/screens/reset_password/bloc/reset_password_bloc.dart';
import 'components/screens/reset_password/reset_password_screen.dart';
import 'components/screens/support/bloc/support_bloc.dart';
import 'components/screens/support/support_screen.dart';
import 'utils/fade_page_route.dart';

export 'extensions/navigator.dart';

final GlobalKey<NavigatorState> rootNavigator = GlobalKey();

abstract class RootRoutes {
  static const String splash = '/splash';
  static const String onboarding = '/onboarding';
  static const String login = '/auth.login';
  static const String registration = '/auth.registration';
  static const String resetPassword = '/auth.resetPassword';
  static const String privacy = '/privacy_policy';
  static const String aboutUs = '/aboutUs';
  static const String home = '/home';
  static const String changePassword = '/changePassword';
  static const String personalData = '/personalData';
  static const String notifications = '/notifications';
  static const String support = '/support';
  static const String hospitalDetails = '/hospitalDetails';
  static const String myPackage = '/myPackage';
  static const String plans = '/plans';
  static const String applyPlan = '/plans.applyPlan';
}

class RootRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RootRoutes.onboarding:
        return FadePageRoute(
          builder: (_) => BlocProvider(
            create: (_) => OnboardingBloc(),
            child: const OnboardingScreen(),
          ),
        );
      case RootRoutes.login:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => LoginBloc(
              accountBloc: context.accountBloc,
            ),
            child: const LoginScreen(),
          ),
        );
      case RootRoutes.registration:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => RegistrationBloc(),
            child: const RegistrationScreen(),
          ),
        );
      case RootRoutes.resetPassword:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => ResetPasswordBloc(),
            child: const ResetPasswordScreen(),
          ),
        );
      case RootRoutes.privacy:
        return MaterialPageRoute(
          builder: (_) => const PrivacyPolicyScreen(),
        );
      case RootRoutes.home:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => PageNavigatorBloc(),
            child: HomeScreen(),
          ),
        );
      case RootRoutes.changePassword:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => ChangePasswordBloc(),
            child: const ChangePasswordScreen(),
          ),
        );
      case RootRoutes.personalData:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => PersonalDataBloc(
              accountBloc: context.accountBloc,
            ),
            child: PersonalDataScreen(),
          ),
        );
      case RootRoutes.support:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => SupportBloc(
              accountBloc: context.accountBloc,
            ),
            child: SupportScreen(),
          ),
        );
      case RootRoutes.notifications:
        return MaterialPageRoute(
          builder: (_) => const NotificationsScreen(),
        );
      case RootRoutes.hospitalDetails:
        final args = settings.arguments as HospitalDetailsArguments;

        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: args.providerBloc,
            child: const HospitalDetailsScreen(),
          ),
        );
      case RootRoutes.myPackage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => PlansBloc(),
            child: const MyPackageScreen(),
          ),
        );
      case RootRoutes.plans:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => PlansBloc(),
            child: const PlansScreen(),
          ),
        );
      case RootRoutes.applyPlan:
        return MaterialPageRoute(
          builder: (_) => const ApplyPlanScreen(),
        );
      case RootRoutes.aboutUs:
        return MaterialPageRoute(
          builder: (_) => const AboutUsScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text(
                'No route defined for ${settings.name}',
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        );
    }
  }
}
