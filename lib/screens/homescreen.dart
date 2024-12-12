import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/time_entry.dart';
import 'providers/time_entry_provider.dart';
import 'edit_time_entry_screen.dart';  // Assuming this is the screen for editing a time entry

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Time Entries'),
      ),
      body: Consumer<TimeEntryProvider>(
        builder: (context, provider, child) {
          return ListView.builder(
            itemCount: provider.entries.length,
            itemBuilder: (context, index) {
              final entry = provider.entries[index];
              return ListTile(
                title: Text('${entry.projectId} - ${entry.totalTime} hours'),
                subtitle: Text('${entry.date.toString()} - Notes: ${entry.notes}'),
                onTap: () {
                  // Navigate to edit screen for the selected time entry
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditTimeEntryScreen(entry: entry),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the screen to add a new time entry
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EditTimeEntryScreen()), // Adjust if you're using a different screen for adding
          );
        },
        child: Icon(Icons.add),
        tooltip: 'Add Time Entry',
      ),
    );
  }
}
