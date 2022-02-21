import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:health_plus/app_colors.dart';
import 'package:health_plus/app_resources.dart';
import 'package:health_plus/model/notification.dart' as hp;
import 'package:intl/intl.dart';
class NotificationWidget extends StatelessWidget {
  const NotificationWidget({
    Key? key,
    required this.notification,
  }) : super(key: key);

  final hp.Notification notification;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0.0, 3.0),
            blurRadius: 6.0,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(AppResources.notifications2),
          const SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTitle(),
                const SizedBox(height: 16.0),
                _buildMessage(),
              ],
            ),
          ),
          const SizedBox(width: 16.0),
          _buildDate(),
        ],
      ),
    );
  }

  Widget _buildDate() {
    String date = '';
    if (notification.sentDate != null) {
      date = DateFormat.MMMMd().format(notification.sentDate!);
    }

    return Text(
      date,
      style: const TextStyle(
        fontSize: 13.0,
        fontFamily: 'Almarai',
        fontWeight: FontWeight.w400,
        color: AppColors.grey,
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      notification.title ?? '',
      style: const TextStyle(
        fontSize: 14.0,
        fontFamily: 'Almarai',
        fontWeight: FontWeight.w700,
        color: AppColors.black,
      ),
    );
  }

  Widget _buildMessage() {
    return Text(
      notification.body ?? '',
      style: const TextStyle(
        height: 1.57,
        fontSize: 14.0,
        fontFamily: 'Almarai',
        fontWeight: FontWeight.w400,
        color: AppColors.grey,
      ),
    );
  }
}
