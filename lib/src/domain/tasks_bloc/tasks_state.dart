part of 'tasks_bloc.dart';

@immutable
sealed class TasksState {}

final class TasksInitial extends TasksState {}

final class TasksLoadingState extends TasksState {}

final class TasksLoadedState extends TasksState {
  final List<Task> tasks;

  TasksLoadedState({required this.tasks});
}
