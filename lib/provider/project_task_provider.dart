import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import '../models/project.dart';
import '../models/task.dart';

class ProjectTaskProvider with ChangeNotifier {
  final LocalStorage storage;
  List<Project> _projects = [];
  List<Task> _tasks = [];

  List<Project> get projects => _projects;
  List<Task> get tasks => _tasks;

  ProjectTaskProvider(this.storage) {
    _loadProjectsFromStorage();
    _loadTasksFromStorage();
  }

  // Load projects from local storage
  void _loadProjectsFromStorage() async {
    await storage.ready;
    var storedProjects = storage.getItem('projects');
    if (storedProjects != null) {
      _projects = List<Project>.from(
        (storedProjects as List).map((item) => Project.fromJson(item)),
      );
      notifyListeners();
    }
  }

  // Load tasks from local storage
  void _loadTasksFromStorage() async {
    await storage.ready;
    var storedTasks = storage.getItem('tasks');
    if (storedTasks != null) {
      _tasks = List<Task>.from(
        (storedTasks as List).map((item) => Task.fromJson(item)),
      );
      notifyListeners();
    }
  }

  // Save projects to local storage
  void _saveProjectsToStorage() {
    storage.setItem('projects', _projects.map((e) => e.toJson()).toList());
  }

  // Save tasks to local storage
  void _saveTasksToStorage() {
    storage.setItem('tasks', _tasks.map((e) => e.toJson()).toList());
  }

  // Add a new project
  void addProject(Project project) {
    _projects.add(project);
    _saveProjectsToStorage();
    notifyListeners();
  }

  // Add a new task
  void addTask(Task task) {
    _tasks.add(task);
    _saveTasksToStorage();
    notifyListeners();
  }

  // Add or update a project
  void addOrUpdateProject(Project project) {
    int index = _projects.indexWhere((p) => p.id == project.id);
    if (index != -1) {
      _projects[index] = project;
    } else {
      _projects.add(project);
    }
    _saveProjectsToStorage();
    notifyListeners();
  }

  // Add or update a task
  void addOrUpdateTask(Task task) {
    int index = _tasks.indexWhere((t) => t.id == task.id);
    if (index != -1) {
      _tasks[index] = task;
    } else {
      _tasks.add(task);
    }
    _saveTasksToStorage();
    notifyListeners();
  }

  // Remove a project by its id
  void removeProject(String id) {
    _projects.removeWhere((project) => project.id == id);
    _saveProjectsToStorage();
    notifyListeners();
  }

  // Remove a task by its id
  void removeTask(String id) {
    _tasks.removeWhere((task) => task.id == id);
    _saveTasksToStorage();
    notifyListeners();
  }
}
