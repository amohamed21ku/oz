import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ToDoPage extends StatefulWidget {
  const ToDoPage({super.key});

  @override
  _ToDoPageState createState() => _ToDoPageState();
}

class _ToDoPageState extends State<ToDoPage> {
  final List<String> users = ['User1', 'User2', 'User3']; // Replace with dynamic user list
  final Map<String, List<Map<String, dynamic>>> userTasks = {};

  @override
  void initState() {
    super.initState();
    for (var user in users) {
      userTasks[user] = [];
    }
  }

  void _addTask(String user, String task) {
    setState(() {
      userTasks[user]?.add({'task': task, 'completed': false});
    });
  }

  void _toggleTaskCompletion(String user, int taskIndex) {
    setState(() {
      userTasks[user]?[taskIndex]['completed'] = !(userTasks[user]?[taskIndex]['completed'] ?? false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do List',style: GoogleFonts.poppins(color: Colors.white),),
        backgroundColor: const Color(0xffa4392f),
        automaticallyImplyLeading: false, // This line removes the default arrow icon

      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return ExpansionTile(
            title: Text(user),
            children: [
              ListView.builder(
                shrinkWrap: true,
                itemCount: userTasks[user]?.length ?? 0,
                itemBuilder: (context, taskIndex) {
                  final task = userTasks[user]?[taskIndex];
                  final completed = task?['completed'] ?? false;
                  return ListTile(
                    leading: Checkbox(
                      value: completed,
                      onChanged: (bool? value) {
                        _toggleTaskCompletion(user, taskIndex);
                      },
                    ),
                    title: Text(
                      task?['task'] ?? '',
                      style: TextStyle(
                        decoration: completed ? TextDecoration.lineThrough : null,
                        color: completed ? Colors.grey : Colors.black,
                      ),
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: const InputDecoration(
                          labelText: 'Add Task',
                        ),
                        onSubmitted: (task) {
                          _addTask(user, task);
                        },
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        final taskController = TextEditingController();
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Add Task for $user'),
                            content: TextField(
                              controller: taskController,
                              decoration: const InputDecoration(hintText: 'Enter task'),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  _addTask(user, taskController.text);
                                  Navigator.pop(context);
                                },
                                child: const Text('Add'),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
