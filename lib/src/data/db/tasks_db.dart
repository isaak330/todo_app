import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_app/src/data/models/task_model.dart';

class TasksDb {
  static const String _tasksBoxName = 'tasks_box';

  static Future<void> addTask(Task task) async {
    final directory = await getApplicationDocumentsDirectory();
    final box = await Isar.open(
      [TaskSchema],
      name: _tasksBoxName,
      directory: directory.path,
    );

    print('++++++++++ $task +++++');

    await box.writeTxn(() async {
      await box.tasks.put(task); // insert & update
    });
    box.close();
  }

  static Future<List<Task>> getTasks() async {
    final directory = await getApplicationDocumentsDirectory();
    final box = await Isar.open(
      [TaskSchema],
      name: _tasksBoxName,
      directory: directory.path,
    );
    var tasks = await box.tasks.where().findAll();
    box.close();
    return tasks;
  }

  static Future<void> deleteTask(int id) async {
    final directory = await getApplicationDocumentsDirectory();
    final box = await Isar.open(
      [TaskSchema],
      name: _tasksBoxName,
      directory: directory.path,
    );

    await box.writeTxn(() async {
      await box.tasks.delete(id);
    });
    box.close();
  }

  static Future<void> updateTask(Task task) async {
    final directory = await getApplicationDocumentsDirectory();
    final box = await Isar.open(
      [TaskSchema],
      name: _tasksBoxName,
      directory: directory.path,
    );

    await box.writeTxn(() async {
      await box.tasks.put(task);
    });
    box.close();
  }
}
