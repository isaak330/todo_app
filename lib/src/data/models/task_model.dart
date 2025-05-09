import 'package:isar/isar.dart';

part 'task_model.g.dart';

@collection
class Task {
  Id id = Isar.autoIncrement;
  String? title;
  String? description;
  DateTime createdAt = DateTime.now();
}
