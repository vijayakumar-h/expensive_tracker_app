// features/tasks/presentation/task_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/task_bloc.dart';
import '../bloc/task_event.dart';
import '../bloc/task_state.dart';
import '../data/task_repository.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // Inject BLoC with Repository (e.g. sl<TaskRepository>())
      create: (context) => TaskBloc(TaskRepository())..add(LoadTaskEvent()),
      child: const _TaskView(),
    );
  }
}

class _TaskView extends StatelessWidget {
  const _TaskView();

  void _showAddTaskDialog(BuildContext context) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Add New Task'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: 'Enter task title'),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (controller.text.trim().isNotEmpty) {
                // Dispatch Event to BLoC
                context.read<TaskBloc>().add(AddTaskEvent(controller.text));
                Navigator.pop(dialogContext);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Tasks')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTaskDialog(context),
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          if (state.status == TaskStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.status == TaskStatus.failure) {
            return Center(child: Text(state.errorMessage ?? 'An error occurred'));
          }

          if (state.tasks.isEmpty) {
            return const Center(child: Text('No tasks yet! Tap + to create one.'));
          }

          return ListView.builder(
            itemCount: state.tasks.length,
            itemBuilder: (context, index) {
              final task = state.tasks[index];
              return Dismissible(
                key: Key(task.id),
                background: Container(color: Colors.red, alignment: Alignment.centerRight, padding: const EdgeInsets.only(right: 20), child: const Icon(Icons.delete, color: Colors.white)),
                onDismissed: (_) {
                  // Dispatch Delete Event
                  context.read<TaskBloc>().add(DeleteTaskEvents(task.id));
                },
                child: CheckboxListTile(
                  title: Text(
                    task.title,
                    style: TextStyle(
                      decoration: task.isComplete ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  value: task.isComplete,
                  onChanged: (_) {
                    // Dispatch Toggle Event
                    context.read<TaskBloc>().add(ToggleTaskEvents(task.id));
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}