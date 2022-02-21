import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_plus/app_colors.dart';
import 'package:health_plus/components/shared_widgets/app_bar/health_app_bar.dart';
import 'package:health_plus/extensions/widget.dart';
import 'package:health_plus/model/notification.dart' as hp;
import 'package:health_plus/utils/tuple.dart';

import 'bloc/notifications_bloc.dart';
import 'widgets/notification_widget.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: AppColors.white,
            appBar: HealthAppBar(
              backNavigation: true,
              notificationsButton: false,
            ),
            body: _buildBody(),
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitle(),
        const SizedBox(height: 24.0),
        BlocSelector<NotificationsBloc, NotificationsState,
            Tuple2<NotificationsStatus, List<hp.Notification>>>(
          selector: (state) => Tuple2(state.status, state.notifications),
          builder: (_, state) {
            final notificationsStatus = state.item1;

            if (notificationsStatus == NotificationsStatus.fetching) {
              return const Expanded(
                child: Center(
                  child: CircularProgressIndicator(
                    color: AppColors.purple,
                  ),
                ),
              );
            }

            final notifications = state.item2;

            if (notifications.isEmpty) {
              return Expanded(
                child: Center(
                  child: const Text(
                    'There are no notifications yet',
                    style: TextStyle(
                      height: 1.33,
                      fontSize: 18.0,
                      fontFamily: 'Almarai',
                      fontWeight: FontWeight.w700,
                      color: AppColors.purpleDarkGrey,
                    ),
                    textAlign: TextAlign.center,
                  ).withPaddingSymmetric(16.0, 0.0),
                ),
              );
            }

            return Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
                itemBuilder: (context, index) {
                  final notification = notifications[index];

                  return Dismissible(
                    key: ValueKey(notification),
                    background: Container(
                      padding: const EdgeInsets.fromLTRB(24.0, 0.0, 0.0, 0.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.red,
                      ),
                      child: const Icon(
                        Icons.delete,
                        color: AppColors.white,
                      ),
                      alignment: Alignment.centerLeft,
                    ),
                    secondaryBackground: Container(
                      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 24.0, 0.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.red,
                      ),
                      child: const Icon(
                        Icons.delete,
                        color: AppColors.white,
                      ),
                      alignment: Alignment.centerRight,
                    ),
                    onDismissed: (_) {
                      context.notificationsBloc
                          .removeNotification(notification);
                    },
                    child: NotificationWidget(
                      notification: notification,
                    ),
                  );
                },
                separatorBuilder: (_, __) {
                  return const SizedBox(height: 16.0);
                },
                itemCount: notifications.length,
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildTitle() {
    return Text(
      'text.notifications'.tr(),
      style: const TextStyle(
        fontSize: 20.0,
        fontFamily: 'Almarai',
        fontWeight: FontWeight.w700,
        color: AppColors.purpleDarkGrey,
      ),
    ).withPadding(16.0, 8.0, 16.0, 0.0);
  }
}
