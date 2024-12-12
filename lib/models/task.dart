class Task {
  final String id;
  final String name;
  final String projectId; // Links the task to a specific project
  final DateTime startDate;
  final DateTime dueDate;
  final String description;
  final String assignedTo; // Name or ID of the person assigned
  final double estimatedHours;
  final String status; // e.g., 'pending', 'in-progress', 'completed'

  Task({
    required this.id,
    required this.name,
    required this.projectId,
    required this.startDate,
    required this.dueDate,
    required this.description,
    required this.assignedTo,
    required this.estimatedHours,
    required this.status,
  });
}
