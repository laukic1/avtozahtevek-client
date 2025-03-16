import 'package:flutter/material.dart';
import 'package:my_app/claims/file_claim_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('avtozahtevek.si'),
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
              const Text(
                "Welcome Back!",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              const Text(
                "Manage your claims easily from here.",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const FileClaimPage()),
                    );
                  },
                  icon: const Icon(Icons.add),
                  label: const Text("File a New Claim"),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                "Your Recent Claims",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
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
        ));
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
          style: TextStyle(fontWeight: FontWeight.bold, color: statusColor),
        ),
      ),
    );
  }
}
