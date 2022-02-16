import 'dart:async';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_plus/model/notification.dart' as hp;
import 'package:health_plus/utils/local_notifications.dart';
import 'package:health_plus/utils/nullable.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

extension BlocExtension on BuildContext {
  NotificationsBloc get notificationsBloc => read<NotificationsBloc>();
}

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  NotificationsBloc() : super(const NotificationsState.initial()) {
    on<LoadNotifications>(_onLoadNotifications);
    on<AddNotification>(_onAddNotification);
    on<RemoveNotification>(_onRemoveNotification);

    _listenNotifications();
    _loadNotifications();
  }

  void removeNotification(hp.Notification notification) {
    add(RemoveNotification(notification: notification));
  }

  void _loadNotifications() async {
    add(const LoadNotifications());
  }

  void _addNotification(hp.Notification notification) {
    add(AddNotification(notification: notification));
  }

  Future<void> _onLoadNotifications(
    LoadNotifications event,
    Emitter<NotificationsState> emit,
  ) async {
    emit(state.copyWith(status: NotificationsStatus.fetching));

    final notifications = LocalNotifications.loadNotifications();

    emit(state.copyWith(
      status: NotificationsStatus.loaded,
      notifications: notifications.reversed.toList(growable: false),
      error: Nullable(null),
    ));
  }

  Future<void> _onAddNotification(
    AddNotification event,
    Emitter<NotificationsState> emit,
  ) async {
    emit(state.copyWith(
      notifications: [event.notification, ...state.notifications],
      error: Nullable(null),
    ));
  }

  Future<void> _onRemoveNotification(
    RemoveNotification event,
    Emitter<NotificationsState> emit,
  ) async {
    emit(state.copyWith(
      notifications: [...state.notifications]..remove(event.notification),
      error: Nullable(null),
    ));

    LocalNotifications.removeNotification(event.notification);
  }

  void _listenNotifications() async {
    final fcm = FirebaseMessaging.instance;
    final fcmToken = await fcm.getToken();
    print('Generated FCM token: $fcmToken');

    FirebaseMessaging.onMessage.listen((message) async {
      String? notificationUrl;
      if (Platform.isAndroid) {
        notificationUrl = message.notification?.android?.imageUrl;
      } else if (Platform.isIOS) {
        notificationUrl = message.notification?.apple?.imageUrl;
      }

      final notification = hp.Notification(
        id: message.hashCode,
        title: message.notification?.title,
        body: message.notification?.body,
        sentDate: message.sentTime,
      );

      LocalNotifications.saveNotification(notification);

      LocalNotifications.showNotification(
        notification.id,
        title: notification.title,
        body: notification.body,
        imageUrl: notificationUrl,
      );

      _addNotification(notification);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((_) async {
      _loadNotifications();
    });
  }
}
