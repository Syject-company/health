part of 'notifications_bloc.dart';

abstract class NotificationsEvent extends Equatable {
  const NotificationsEvent();

  @override
  List<Object> get props => [];
}

class LoadNotifications extends NotificationsEvent {
  const LoadNotifications();
}

class AddNotification extends NotificationsEvent {
  const AddNotification({required this.notification});

  final hp.Notification notification;

  @override
  List<Object> get props => [notification];
}

class RemoveNotification extends NotificationsEvent {
  const RemoveNotification({required this.notification});

  final hp.Notification notification;

  @override
  List<Object> get props => [notification];
}
