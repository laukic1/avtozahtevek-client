import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // ✅ To open email & phone

class SupportPage extends StatelessWidget {
  const SupportPage({super.key});

  // ✅ Open Email App
  void _sendEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'support@example.com',
      query: 'subject=App Support Request',
    );
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      debugPrint("Could not launch email app");
    }
  }

  // ✅ Make a Phone Call
  void _callSupport() async {
    final Uri phoneUri = Uri(
      scheme: 'tel',
      path: '+1234567890', // ✅ Support number
    );
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      debugPrint("Could not make call");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pomoč in podpora'),
        centerTitle: true,
        backgroundColor: Colors.white, // ✅ White Background
        elevation: 4, // ✅ Adds Bottom Shadow
        shadowColor: Colors.white, // ✅ Subtle shadow
        foregroundColor: Colors.black, // ✅ Black text/icons for contrast
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text(
              "Frequently Asked Questions",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ExpansionTile(
              title: const Text("How long does claim processing take?"),
              children: [const Padding(padding: EdgeInsets.all(8.0), child: Text("Processing usually takes 5-7 business days."))],
            ),
            ExpansionTile(
              title: const Text("What documents do I need to submit?"),
              children: [const Padding(padding: EdgeInsets.all(8.0), child: Text("You'll need your insurance policy and accident report."))],
            ),
            ExpansionTile(
              title: const Text("How can I track my claim status?"),
              children: [const Padding(padding: EdgeInsets.all(8.0), child: Text("You can track your claim in the 'Claims' section."))],
            ),
            const SizedBox(height: 20),

            // ✅ Contact Support
            const Text(
              "Contact Support",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ListTile(
              leading: const Icon(Icons.email, color: Colors.blue),
              title: const Text("support@example.com"),
              onTap: _sendEmail,
            ),
            ListTile(
              leading: const Icon(Icons.phone, color: Colors.green),
              title: const Text("+1 234 567 890"),
              onTap: _callSupport,
            ),
          ],
        ),
      ),
    );
  }
}
