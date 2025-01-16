import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/core/usecases/logout_usecase.dart';
import 'package:task_manager/features/auth/presentation/screens/auth_screen.dart';
import '../../domain/entities/task.dart';
import '../provider/task_provider.dart';
import '../widgets/add_task_bottom_sheet.dart';
import '../widgets/edit_task_dialog.dart';
import '../widgets/task_list_tile.dart';

class TasksPage extends StatefulWidget {
  @override
  _TasksPageState createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  @override
  void initState() {
    super.initState();
    // Fetch initial tasks when the page opens for the first time
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final taskProvider = Provider.of<TaskProvider>(context, listen: false);
      taskProvider.fetchTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Manager'),
        actions: [
          // Filter Button
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _showFilterDialog,
          ),
          // Sign Out Button (example)
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: _signOut,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: taskProvider.isLoading && taskProvider.tasks.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
              itemCount: taskProvider.tasks.length + 1,
              itemBuilder: (context, index) {
                if (index < taskProvider.tasks.length) {
                  final task = taskProvider.tasks[index];
                  return TaskListTile(
                    task: task,
                    onDelete: () async {
                      try {
                        await taskProvider.deleteTask(task.id);

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Task deleted successfully!')),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Failed to delete task: $e')),
                        );
                      }
                    },
                    onEdit: () => _showEditTaskPopup(context, task),
                  );
                }
                // Show "Load More" button at the end
                return taskProvider.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () => taskProvider.fetchTasks(
                      append: true,
                    ),
                    child: const Text('Load More'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTaskBottomSheet(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Select Filter'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('All'),
              onTap: () {
                final taskProvider = Provider.of<TaskProvider>(context, listen: false);
                taskProvider.setStatusFilter('all');
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Completed'),
              onTap: () {
                final taskProvider = Provider.of<TaskProvider>(context, listen: false);
                taskProvider.setStatusFilter('completed'); // Apply completed filter
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Incomplete'),
              onTap: () {
                final taskProvider = Provider.of<TaskProvider>(context, listen: false);
                taskProvider.setStatusFilter('incomplete');  // Apply incomplete filter
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }


  // Function to show Add Task Bottom Sheet
  void _showAddTaskBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: AddTaskBottomSheet(),
      ),
    );
  }

  // Function to show Edit Task Popup
  void _showEditTaskPopup(BuildContext context, Task task) {
    showDialog(
      context: context,
      builder: (_) => EditTaskDialog(task: task),
    );
  }

  void _signOut() async {
    try {
      await LogoutUseCase().execute();

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => AuthScreen()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sign-out failed. Please try again.')),
      );
    }
  }

}
