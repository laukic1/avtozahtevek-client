import 'package:flutter/material.dart';
import 'package:my_app/app/navigation/persistent_nav_page.dart';
import 'package:my_app/home/home_page.dart';
import 'package:my_app/widgets/loading_overlay.dart'; // ✅ Navigate back to Home after submission

class SubmitClaimPage extends StatelessWidget {
  const SubmitClaimPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('5 - Oddaj zahtevek'),
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
              "Review Your Claim",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // ✅ Placeholder for Claim Review Data
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("📅 Incident Date: 2024-05-10"),
                  Text("⏰ Incident Time: 14:30"),
                  Text("🚗 Vehicle: Toyota Corolla 2022"),
                  Text("📝 Description: Rear-ended at traffic light."),
                  Text("📄 Police Report: Uploaded"),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // ✅ Submit Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  LoadingOverlay.show(context); // ✅ Show loader

                  await Future.delayed(const Duration(milliseconds: 500)); // ✅ Allow brief delay

                  LoadingOverlay.hide(); // ✅ Hide loader before showing confirmation

                  // ✅ Show Confirmation Dialog
                  await showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Claim Submitted"),
                      content: const Text(
                          "Your claim has been successfully submitted!\nTracking ID: #123456"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            // ✅ Ensure navigation bar is visible by redirecting to PersistentNavPage
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => const PersistentNavPage()), // ✅ Redirect to the correct nav structure
                                  (route) => false,
                            );
                          },
                          child: const Text("OK"),
                        ),
                      ],
                    ),
                  );
                },


                child: const Text('Submit Claim'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
