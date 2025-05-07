import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/src/data/models/task_model.dart';
import 'package:todo_app/src/domain/tasks_bloc/tasks_bloc.dart';

class NoteScreen extends StatefulWidget {
  final Task note;
  final TasksBloc tasksBloc;
  const NoteScreen({super.key, required this.note, required this.tasksBloc});

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.note.title);
    descriptionController = TextEditingController(
      text: widget.note.description,
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.note.title ?? 'Заметка'),
        actions: [
          IconButton(
            icon: Icon(isEditing ? Icons.save : Icons.edit),
            onPressed: () {
              if (isEditing) {
                if (titleController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Название не может быть пустым'),
                    ),
                  );
                  return;
                }
                final updatedNote =
                    Task()
                      ..id = widget.note.id
                      ..title = titleController.text
                      ..description = descriptionController.text
                      ..createdAt = widget.note.createdAt;

                widget.tasksBloc.add(TasksUpdateEvent(task: updatedNote));
                Navigator.pop(context);
              }
              setState(() {
                isEditing = !isEditing;
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: titleController,
              enabled: isEditing,
              decoration: const InputDecoration(
                labelText: 'Название',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: TextField(
                controller: descriptionController,
                enabled: isEditing,
                maxLines: null,
                expands: true,
                decoration: const InputDecoration(
                  labelText: 'Описание',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
