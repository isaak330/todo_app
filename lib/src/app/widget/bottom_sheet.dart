import 'package:flutter/material.dart';
import 'package:todo_app/src/data/models/task_model.dart';
import 'package:todo_app/src/domain/tasks_bloc/tasks_bloc.dart';

class BottomSheetWidget extends StatefulWidget {
  final TasksBloc tasksBloc;
  const BottomSheetWidget({super.key, required this.tasksBloc});

  @override
  State<BottomSheetWidget> createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Text(
            'Новая заметка',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          TextFormField(
            // keyboardType: TextInputType.multiline,
            controller: titleController,
            // maxLines: 10,
            decoration: InputDecoration(
              hintText: 'Название',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
            ),
          ),
          SizedBox(height: 8),
          TextFormField(
            keyboardType: TextInputType.multiline,
            controller: descriptionController,
            maxLines: 10,
            decoration: InputDecoration(
              hintText: 'Описание',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
            ),
          ),
          SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {
              final newTask =
                  Task()
                    ..title = titleController.text
                    ..description = descriptionController.text;
              widget.tasksBloc.add(TasksAddEvent(task: newTask));
              Navigator.pop(context);
            },
            child: Text('Сохранить'),
          ),
        ],
      ),
    );
  }
}
