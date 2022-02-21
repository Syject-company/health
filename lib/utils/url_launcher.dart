import 'dart:io';

import 'package:url_launcher/url_launcher.dart';

class UrlLauncher {
  static Future<void> mailTo(
    String email, {
    String subject = '',
    String message = '',
  }) async {
    String url = 'mailto:$email?subject=$subject&body=$message';

    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  static Future<void> phoneTo(String phoneNumber) async {
    final url = 'tel:$phoneNumber';

    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  static Future<void> whatsappTo(String phoneNumber) async {
    final urlAndroid = 'whatsapp://send?phone=$phoneNumber';
    final urlIOS = 'https://wa.me/$phoneNumber';

    if (Platform.isIOS) {
      if (await canLaunch(urlIOS)) {
        await launch(urlIOS, forceSafariVC: false);
      }
    } else {
      if (await canLaunch(urlAndroid)) {
        await launch(urlAndroid);
      }
    }
  }
}
