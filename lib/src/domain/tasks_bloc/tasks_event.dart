part of 'tasks_bloc.dart';

@immutable
sealed class TasksEvent {}

final class TasksGetEvent extends TasksEvent {}

final class TasksDeleteEvent extends TasksEvent {
  final int id;

  TasksDeleteEvent({required this.id});
}

final class TasksAddEvent extends TasksEvent {
  final Task task;

  TasksAddEvent({required this.task});
}

final class TasksUpdateEvent extends TasksEvent {
  final Task task;

  TasksUpdateEvent({required this.task});
}

final class TasksToggleEvent extends TasksEvent {
  final int id;

  TasksToggleEvent({required this.id});
}
