import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/project.dart';
import 'models/task.dart';
import 'providers/project_task_provider.dart';

class ProjectTaskManagementScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Projects and Tasks'),
      ),
      body: Consumer<ProjectTaskProvider>(
        builder: (context, provider, child) {
          return ListView.builder(
            itemCount: provider.projects.length, // Assuming you have a list of projects
            itemBuilder: (context, index) {
              final project = provider.projects[index];
              return ListTile(
                title: Text(project.name),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: project.tasks.map((task) => Text(task.name)).toList(), // List tasks for each project
                ),
                onTap: () {
                  // You can implement a navigation or detail screen here for editing or viewing a project/task
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddProjectTaskDialog(context);
        },
        child: Icon(Icons.add),
        tooltip: 'Add Project/Task',
      ),
    );
  }

  // Show a dialog to add a new project or task
  void _showAddProjectTaskDialog(BuildContext context) {
    final TextEditingController _projectNameController = TextEditingController();
    final TextEditingController _taskNameController = TextEditingController();
    String selectedType = 'Project';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Project or Task'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButton<String>(
                value: selectedType,
                onChanged: (String? newValue) {
                  selectedType = newValue!;
                },
                items: ['Project', 'Task']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              if (selectedType == 'Project')
                TextField(
                  controller: _projectNameController,
                  decoration: InputDecoration(labelText: 'Project Name'),
                ),
              if (selectedType == 'Task')
                TextField(
                  controller: _taskNameController,
                  decoration: InputDecoration(labelText: 'Task Name'),
                ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (selectedType == 'Project') {
                  final newProject = Project(
                    name: _projectNameController.text,
                    tasks: [],
                  );
                  Provider.of<ProjectTaskProvider>(context, listen: false)
                      .addProject(newProject);
                } else if (selectedType == 'Task') {
                  final newTask = Task(
                    name: _taskNameController.text,
                  );
                  // Assuming you need to select a project to add the task to
                  Provider.of<ProjectTaskProvider>(context, listen: false)
                      .addTaskToProject(newTask);
                }
                Navigator.pop(context);
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
