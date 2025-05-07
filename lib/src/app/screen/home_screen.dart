import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/src/app/screen/note_screen.dart';
import 'package:todo_app/src/app/widget/bottom_sheet.dart';
import 'package:todo_app/src/domain/tasks_bloc/tasks_bloc.dart';
import 'package:todo_app/src/domain/theme_cubit/theme_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tasksBloc = TasksBloc();
    return BlocProvider(
      create: (context) => tasksBloc..add(TasksGetEvent()),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            showModalBottomSheet(
              context: context,
              builder:
                  (BuildContext context) =>
                      BottomSheetWidget(tasksBloc: tasksBloc),
            );
          },
          child: const Icon(Icons.add),
        ),
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              BlocBuilder<ThemeCubit, ThemeState>(
                builder: (context, state) {
                  return SliverAppBar(
                    title: Text('Заметки'),
                    centerTitle: true,
                    actions: [
                      IconButton(
                        onPressed: () {
                          context.read<ThemeCubit>().toggleTheme();
                        },
                        icon:
                            state is LightThemeState
                                ? Icon(Icons.toggle_on_sharp)
                                : Icon(Icons.toggle_off_sharp),
                      ),
                    ],
                  );
                },
              ),
              BlocBuilder<TasksBloc, TasksState>(
                builder: (context, state) {
                  if (state is TasksLoadedState) {
                    var items = state.tasks;
                    if (items.isEmpty) {
                      return const SliverFillRemaining(
                        child: Center(child: Text('Нет заметок')),
                      );
                    }
                    return SliverList.separated(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        return Dismissible(
                          key: Key(items[index].id.toString()),
                          background: Container(
                            color: Colors.red,
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.only(right: 16),
                            child: const Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                          direction: DismissDirection.endToStart,
                          onDismissed: (direction) {
                            context.read<TasksBloc>().add(
                              TasksDeleteEvent(id: items[index].id),
                            );
                          },
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => NoteScreen(
                                        note: items[index],
                                        tasksBloc: tasksBloc,
                                      ),
                                ),
                              );
                            },
                            focusColor: Colors.red,
                            title: Text(items[index].title ?? ''),
                            subtitle: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(items[index].description ?? ''),
                                Text(
                                  "${items[index].createdAt.day < 10 ? 0 : ''}${items[index].createdAt.day}.${items[index].createdAt.month < 10 ? 0 : ''}${items[index].createdAt.month}.${items[index].createdAt.year}",
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 10);
                      },
                    );
                  }
                  return const SliverFillRemaining(
                    child: Center(child: CircularProgressIndicator()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
