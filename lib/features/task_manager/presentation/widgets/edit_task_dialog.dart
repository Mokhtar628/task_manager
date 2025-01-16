import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/task.dart';
import '../provider/task_provider.dart';

class EditTaskDialog extends StatefulWidget {
  final Task task;

  EditTaskDialog({required this.task});

  @override
  _EditTaskDialogState createState() => _EditTaskDialogState();
}

class _EditTaskDialogState extends State<EditTaskDialog> {
  late TextEditingController _controller;
  late bool _isCompleted;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.task.todo);
    _isCompleted = widget.task.completed;
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);

    return AlertDialog(
      title: const Text('Edit Task'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _controller,
            decoration: const InputDecoration(
              labelText: 'Task',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Completed'),
              Checkbox(
                value: _isCompleted,
                onChanged: (value) {
                  setState(() {
                    _isCompleted = value!;
                  });
                },
              ),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () async {
            final updatedTask = Task(
              id: widget.task.id,
              todo: _controller.text,
              completed: _isCompleted,
            );
            try {
              await taskProvider.updateTask(updatedTask);
              // Show success alert for edit
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Task edited successfully!')),
              );
            } catch (e) {
              // Handle exception and show error message
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Failed to edit task: $e')),
              );
            }

            Navigator.of(context).pop();
          },
          child: const Text('Update'),
        ),
      ],
    );
  }
}
