import 'package:flutter/material.dart';
import '../models/task.dart';
import '../database/task_database.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({Key? key}) : super(key: key);

  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  late Future<List<Task>> _taskList;
  final TaskDatabase _taskDatabase = TaskDatabase.instance;

  @override
  void initState() {
    super.initState();
    _refreshTasks();
  }

  void _refreshTasks() {
    setState(() {
      _taskList = _taskDatabase.getTasks();
    });
  }

  void _showTaskDialog({Task? task}) {
    final titleController = TextEditingController(text: task?.title);
    final descriptionController =
        TextEditingController(text: task?.description);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(task == null ? 'Add Task' : 'Edit Task'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                final title = titleController.text;
                final description = descriptionController.text;

                if (title.isNotEmpty && description.isNotEmpty) {
                  if (task == null) {
                    await _taskDatabase.insertTask(
                      Task(title: title, description: description),
                    );
                  } else {
                    await _taskDatabase.updateTask(
                      Task(
                        id: task.id,
                        title: title,
                        description: description,
                        isComplete: task.isComplete,
                      ),
                    );
                  }

                  _refreshTasks();
                  Navigator.pop(context);
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do List'),
      ),
      body: FutureBuilder<List<Task>>(
        future: _taskList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading tasks'));
          } else if (snapshot.hasData) {
            final tasks = snapshot.data!;

            return ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];

                return ListTile(
                  title: Text(task.title),
                  subtitle: Text(task.description),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Checkbox(
                        value: task.isComplete,
                        onChanged: (value) async {
                          await _taskDatabase.updateTask(
                            Task(
                              id: task.id,
                              title: task.title,
                              description: task.description,
                              isComplete: value ?? false,
                            ),
                          );
                          _refreshTasks();
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () async {
                          await _taskDatabase.deleteTask(task.id!);
                          _refreshTasks();
                        },
                      ),
                    ],
                  ),
                  onTap: () => _showTaskDialog(task: task),
                );
              },
            );
          } else {
            return const Center(child: Text('No tasks found'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showTaskDialog(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
