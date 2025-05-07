import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_app/src/data/db/tasks_db.dart';
import 'package:todo_app/src/data/models/task_model.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  TasksBloc() : super(TasksInitial()) {
    on<TasksGetEvent>(_onGetTasks);
    on<TasksAddEvent>(_onAddTask);
    on<TasksDeleteEvent>(_onDeleteTask);
    on<TasksUpdateEvent>(_onUpdateTask);
  }

  void _onGetTasks(TasksGetEvent event, Emitter<TasksState> emit) async {
    emit(TasksLoadingState());
    final tasks = await TasksDb.getTasks();
    emit(TasksLoadedState(tasks: tasks));
  }

  void _onAddTask(TasksAddEvent event, Emitter<TasksState> emit) async {
    emit(TasksLoadingState());
    await TasksDb.addTask(event.task);
    final tasks = await TasksDb.getTasks();
    emit(TasksLoadedState(tasks: tasks));
  }

  void _onDeleteTask(TasksDeleteEvent event, Emitter<TasksState> emit) async {
    await TasksDb.deleteTask(event.id);
    final tasks = await TasksDb.getTasks();
    emit(TasksLoadedState(tasks: tasks));
  }

  void _onUpdateTask(TasksUpdateEvent event, Emitter<TasksState> emit) async {
    emit(TasksLoadingState());
    await TasksDb.updateTask(event.task);
    final tasks = await TasksDb.getTasks();
    emit(TasksLoadedState(tasks: tasks));
  }
}
