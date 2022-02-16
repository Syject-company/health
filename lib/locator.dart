import 'package:get_it/get_it.dart';

import 'components/screens/change_password/data/change_password_service.dart';
import 'components/screens/favourites/data/favourite_service.dart';
import 'components/screens/login/data/login_service.dart';
import 'components/screens/medical_network/data/category_service.dart';
import 'components/screens/medical_network/data/provider_service.dart';
import 'components/screens/my_account/data/account_service.dart';
import 'components/screens/offers/data/promotions_service.dart';
import 'components/screens/personal_data/data/profile_service.dart';
import 'components/screens/plans/data/plans_page_service.dart';
import 'components/screens/registration/data/registration_service.dart';
import 'components/screens/reset_password/data/reset_password_service.dart';
import 'components/screens/static_pages/data/static_pages_service.dart';
import 'components/screens/support/data/support_service.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerSingleton<LoginService>(LoginService());
  locator.registerSingleton<RegistrationService>(RegistrationService());
  locator.registerSingleton<ResetPasswordService>(ResetPasswordService());
  locator.registerSingleton<AccountService>(AccountService());
  locator.registerSingleton<ChangePasswordService>(ChangePasswordService());
  locator.registerSingleton<ProfileService>(ProfileService());
  locator.registerSingleton<SupportService>(SupportService());
  locator.registerSingleton<StaticPagesService>(StaticPagesService());
  locator.registerSingleton<PlanService>(PlanService());
  locator.registerSingleton<CategoryService>(CategoryService());
  locator.registerSingleton<ProviderService>(ProviderService());
  locator.registerSingleton<PromotionService>(PromotionService());
  locator.registerSingleton<FavouriteService>(FavouriteService());
}
