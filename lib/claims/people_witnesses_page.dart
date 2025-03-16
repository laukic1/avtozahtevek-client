import 'package:flutter/material.dart';
import 'package:my_app/claims/police_report_page.dart';
import 'package:my_app/profile/support_page.dart';
import 'package:my_app/widgets/loading_overlay.dart'; // ✅ Step 4 (Police Report)

class PeopleWitnessesPage extends StatefulWidget {
  const PeopleWitnessesPage({super.key});

  @override
  _PeopleWitnessesPageState createState() => _PeopleWitnessesPageState();
}

class _PeopleWitnessesPageState extends State<PeopleWitnessesPage> {
  final _formKey = GlobalKey<FormState>();

  // ✅ Driver & Witness Details
  String _driverName = "";
  String _driverLicense = "";
  String? _otherPartyName;
  String? _otherPartyLicense;
  String? _witnessName;
  String? _witnessContact;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('3 - Nezgodne priče'),
        centerTitle: true,
        backgroundColor: Colors.white, // ✅ White Background
        elevation: 4, // ✅ Adds Bottom Shadow
        shadowColor: Colors.white, // ✅ Subtle shadow
        foregroundColor: Colors.black, // ✅ Black text/icons for contrast
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ✅ Driver Name
              const Text("Your Name", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Enter your full name",
                ),
                onChanged: (value) => setState(() => _driverName = value),
                validator: (value) => value == null || value.isEmpty ? "Required" : null,
              ),
              const SizedBox(height: 16),

              // ✅ Driver License Number
              const Text("Your Driver's License", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Enter your driver's license number",
                ),
                onChanged: (value) => setState(() => _driverLicense = value),
                validator: (value) => value == null || value.isEmpty ? "Required" : null,
              ),
              const SizedBox(height: 16),

              // ✅ Other Party (Optional)
              const Text("Other Party (if applicable)", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Other Party Name (Optional)",
                ),
                onChanged: (value) => setState(() => _otherPartyName = value),
              ),
              const SizedBox(height: 8),
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Other Party License (Optional)",
                ),
                onChanged: (value) => setState(() => _otherPartyLicense = value),
              ),
              const SizedBox(height: 16),

              // ✅ Witness (Optional)
              const Text("Witness Information (if available)", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Witness Name (Optional)",
                ),
                onChanged: (value) => setState(() => _witnessName = value),
              ),
              const SizedBox(height: 8),
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Witness Contact (Optional)",
                ),
                keyboardType: TextInputType.phone,
                onChanged: (value) => setState(() => _witnessContact = value),
              ),
              const SizedBox(height: 20),

              // ✅ "Next" Button (Moves to Step 4)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_driverLicense == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please select a date before proceeding!')),
                      );
                      return;
                    }

                    LoadingOverlay.show(context); // ✅ Show loader

                    await Future.delayed(const Duration(milliseconds: 300)); // ✅ Allow brief delay for smoother UX

                    LoadingOverlay.hide(); // ✅ Hide loader BEFORE navigating

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const PoliceReportPage()),
                    );
                  },
                  child: const Text('Next →'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
