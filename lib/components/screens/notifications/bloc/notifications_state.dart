part of 'notifications_bloc.dart';

enum NotificationsStatus {
  empty,
  fetching,
  loaded,
  error,
  warning,
}

class NotificationsState extends Equatable {
  const NotificationsState._({
    required this.status,
    required this.notifications,
    this.error,
  });

  const NotificationsState.initial()
      : this._(
          status: NotificationsStatus.empty,
          notifications: const [],
        );

  final NotificationsStatus status;
  final List<hp.Notification> notifications;
  final String? error;

  NotificationsState copyWith({
    NotificationsStatus? status,
    List<hp.Notification>? notifications,
    Nullable<String>? error,
  }) =>
      NotificationsState._(
        status: status ?? this.status,
        notifications: notifications ?? this.notifications,
        error: error != null ? error.value : this.error,
      );

  @override
  List<Object?> get props => [
        status,
        notifications,
        error,
      ];
}
