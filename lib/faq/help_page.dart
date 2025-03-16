import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

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
            // ✅ Introduction Section
            const Text(
              "Need Help?",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              "Find answers to frequently asked questions below. If you need further assistance, feel free to contact our support team.",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 20),

            // ✅ FAQ Section (Accordion)
            const Text(
              "Frequently Asked Questions",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ExpansionTile(
              title: const Text("How long does claim processing take?"),
              children: const [
                Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text(
                    "Most claims are processed within 7-10 business days. Some cases may take longer depending on additional documentation required.",
                  ),
                ),
              ],
            ),
            ExpansionTile(
              title: const Text("What should I do after an accident?"),
              children: const [
                Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text(
                    "Ensure everyone's safety, call emergency services if needed, take photos, gather witness details, and submit your claim through the app.",
                  ),
                ),
              ],
            ),
            ExpansionTile(
              title: const Text("How can I check my claim status?"),
              children: const [
                Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text(
                    "You can track your claim status in the 'Claims History' tab. Updates will also be sent via email.",
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // ✅ Help Center Contact
            const Text(
              "Still Need Help?",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // 📧 Email Support
                    ListTile(
                      leading: const Icon(Icons.email, color: Colors.blue),
                      title: const Text("Email Support"),
                      subtitle: const Text("support@insurance.com"),
                      onTap: () {
                        // 📧 Open email app
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Opening email app...")),
                        );
                      },
                    ),
                    const Divider(),

                    // 📞 Phone Support
                    ListTile(
                      leading: const Icon(Icons.phone, color: Colors.green),
                      title: const Text("Call Support"),
                      subtitle: const Text("+1 800-555-1234"),
                      onTap: () {
                        // 📞 Open phone dialer
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Dialing support...")),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
