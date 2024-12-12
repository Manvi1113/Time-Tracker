class Project {
  final String id;
  final String name;
  final DateTime startDate;
  final DateTime dueDate;
  final String description;
  final String clientName;
  final double budget;
  final String status; // e.g., 'ongoing', 'completed', etc.
  
  Project({
    required this.id,
    required this.name,
    required this.startDate,
    required this.dueDate,
    required this.description,
    required this.clientName,
    required this.budget,
    required this.status,
  });
}
