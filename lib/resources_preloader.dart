import 'package:flutter/painting.dart';

import 'app_resources.dart';
import 'utils/preload_image.dart';
import 'utils/preload_svg.dart';

Future<void> preloadResources() async {
  await Future.wait([
    preloadImage(const AssetImage(AppResources.amicoInsurance)),
    preloadImage(const AssetImage(AppResources.amicoOnlineDoctor)),
    preloadImage(const AssetImage(AppResources.amicoPharmacist)),
    preloadImage(const AssetImage(AppResources.startAsProvider)),
    preloadImage(const AssetImage(AppResources.hospitalIcon)),
    preloadImage(const AssetImage(AppResources.mapPin)),
  ]);

  await Future.wait([
    preloadSvg(AppResources.discount),
    preloadSvg(AppResources.arrowBack),
    preloadSvg(AppResources.arrowNext),
    preloadSvg(AppResources.arrowNext2),
    preloadSvg(AppResources.reload),
    preloadSvg(AppResources.check),
    preloadSvg(AppResources.logoColored),
    preloadSvg(AppResources.logoWithLabelWhite),
    preloadSvg(AppResources.logoWithLabelColored),
    preloadSvg(AppResources.dialogWarning),
    preloadSvg(AppResources.dialogError),
    preloadSvg(AppResources.dialogSuccess),
    preloadSvg(AppResources.home),
    preloadSvg(AppResources.medicalNetwork),
    preloadSvg(AppResources.offers),
    preloadSvg(AppResources.favourites),
    preloadSvg(AppResources.myAccount),
    preloadSvg(AppResources.emptyAvatar),
    preloadSvg(AppResources.notifications),
    preloadSvg(AppResources.notifications2),
    preloadSvg(AppResources.filters),
    preloadSvg(AppResources.star),
    preloadSvg(AppResources.avatar),
    preloadSvg(AppResources.profile),
    preloadSvg(AppResources.package),
    preloadSvg(AppResources.privacyPolicy),
    preloadSvg(AppResources.aboutUs),
    preloadSvg(AppResources.support),
    preloadSvg(AppResources.changePassword),
    preloadSvg(AppResources.language),
    preloadSvg(AppResources.login),
    preloadSvg(AppResources.logout),
    preloadSvg(AppResources.favourite),
    preloadSvg(AppResources.favouriteChecked),
    preloadSvg(AppResources.geoPin),
    preloadSvg(AppResources.mail),
    preloadSvg(AppResources.phone),
    preloadSvg(AppResources.whatsapp),
    preloadSvg(AppResources.listView),
    preloadSvg(AppResources.mapView),
    preloadSvg(AppResources.watermark),
    preloadSvg(AppResources.cardBackgroundIcon),
  ]);
}
