import 'package:device_preview/device_preview.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization_loader/easy_localization_loader.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_plus/app_constants.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'app_colors.dart';
import 'components/screens/about_us/bloc/about_us_bloc.dart';
import 'components/screens/favourites/bloc/favourites_bloc.dart';
import 'components/screens/medical_network/bloc/medical_network/medical_network_bloc.dart';
import 'components/screens/my_account/bloc/account_bloc.dart';
import 'components/screens/notifications/bloc/notifications_bloc.dart';
import 'components/screens/offers/bloc/offers_bloc.dart';
import 'components/screens/privacy_policy/bloc/privacy_policy_bloc.dart';
import 'components/screens/splash/splash_screen.dart';
import 'firebase_options.dart';
import 'locator.dart';
import 'resources_preloader.dart';
import 'router.dart';
import 'utils/local_notifications.dart';
import 'utils/local_storage.dart';
import 'utils/session_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await LocalNotifications.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await LocalStorage.ensureInitialized();
  await preloadResources();
  setupLocator();

  final initialRoute = await _defineInitialRoute();

  runApp(
    DevicePreview(
      enabled: false,
      builder: (_) {
        return EasyLocalization(
          saveLocale: true,
          path: AppConstants.i18nBasePath,
          supportedLocales: AppConstants.locales,
          useOnlyLangCode: !AppConstants.useCountryCode,
          fallbackLocale: AppConstants.defaultLocale,
          useFallbackTranslations: true,
          assetLoader: YamlAssetLoader(),
          child: HealthPlusApp(initialRoute: initialRoute),
        );
      },
    ),
  );
}

class HealthPlusApp extends StatelessWidget {
  const HealthPlusApp({
    Key? key,
    required this.initialRoute,
  }) : super(key: key);

  final String initialRoute;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AccountBloc(),
          lazy: false,
        ),
        BlocProvider(
          create: (_) => NotificationsBloc(),
          lazy: false,
        ),
        BlocProvider(
          create: (context) => OffersBloc(accountBloc: context.accountBloc),
          lazy: false,
        ),
        BlocProvider(
          create: (context) => FavouritesBloc(accountBloc: context.accountBloc),
          lazy: false,
        ),
        BlocProvider(
          create: (_) => MedicalNetworkBloc(),
          lazy: false,
        ),
        BlocProvider(
          create: (_) => PrivacyPolicyBloc(),
          lazy: false,
        ),
        BlocProvider(
          create: (_) => AboutUsBloc(),
          lazy: false,
        ),
      ],
      child: MaterialApp(
        builder: (context, child) {
          return DevicePreview.appBuilder(
            context,
            ResponsiveWrapper.builder(
              child,
              minWidth: 414,
              defaultScale: true,
              breakpoints: [
                const ResponsiveBreakpoint.resize(
                  480,
                  name: MOBILE,
                  scaleFactor: 1.25,
                ),
              ],
            ),
          );
        },
        title: 'Health Plus',
        navigatorKey: rootNavigator,
        useInheritedMediaQuery: true,
        onGenerateRoute: RootRouter.generateRoute,
        home: SplashScreen(navigateAfter: initialRoute),
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: theme,
      ),
    );
  }

  ThemeData get theme {
    return ThemeData(
      primaryColor: AppColors.purple,
      scaffoldBackgroundColor: AppColors.white,
      dialogBackgroundColor: AppColors.white,
      backgroundColor: AppColors.white,
      colorScheme: ColorScheme.fromSwatch(
        accentColor: AppColors.purple,
      ),
    );
  }
}

Future<String> _defineInitialRoute() async {
  if (LocalStorage.firstLaunch ?? true) {
    return RootRoutes.onboarding;
  }

  if (await SessionManager.isAuthenticated) {
    return RootRoutes.home;
  }

  return RootRoutes.login;
}
