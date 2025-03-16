import 'package:flutter/material.dart';

class StatusPage extends StatelessWidget {
  const StatusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Status'),
        centerTitle: true,
        backgroundColor: Colors.white, // ✅ White Background
        elevation: 4, // ✅ Adds Bottom Shadow
        shadowColor: Colors.white, // ✅ Subtle shadow
        foregroundColor: Colors.black, // ✅ Black text/icons for contrast
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ✅ Title
            const Text(
              "Your Claims",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // ✅ Claims List (Placeholder for now)
            Expanded(
              child: ListView(
                children: const [
                  ClaimStatusCard(
                    title: "Claim #12345",
                    date: "June 10, 2024",
                    status: "Processing",
                    statusColor: Colors.orange,
                  ),
                  ClaimStatusCard(
                    title: "Claim #12344",
                    date: "May 28, 2024",
                    status: "Approved",
                    statusColor: Colors.green,
                  ),
                  ClaimStatusCard(
                    title: "Claim #12343",
                    date: "May 15, 2024",
                    status: "Rejected",
                    statusColor: Colors.red,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ✅ Custom Claim Status Card Widget
class ClaimStatusCard extends StatelessWidget {
  final String title;
  final String date;
  final String status;
  final Color statusColor;

  const ClaimStatusCard({
    super.key,
    required this.title,
    required this.date,
    required this.status,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 3,
      child: ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(date),
        trailing: Text(
          status,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: statusColor,
          ),
        ),
        onTap: () {
          // TODO: Navigate to claim details page (later)
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Clicked on $title")),
          );
        },
      ),
    );
  }
}
