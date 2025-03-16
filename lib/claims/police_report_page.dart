import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // ✅ For file selection
import 'dart:io';
import 'package:my_app/home/home_page.dart';
import 'package:my_app/claims/submit_claim_page.dart';
import 'package:my_app/widgets/loading_overlay.dart';// ✅ After submission, return to Home

class PoliceReportPage extends StatefulWidget {
  const PoliceReportPage({super.key});

  @override
  _PoliceReportPageState createState() => _PoliceReportPageState();
}

class _PoliceReportPageState extends State<PoliceReportPage> {
  final _formKey = GlobalKey<FormState>();
  XFile? _policeReportFile; // ✅ Selected police report file
  final ImagePicker _picker = ImagePicker();
  String _reportNumber = "";

  // ✅ Select File (Gallery / File Picker)
  Future<void> _pickReportFile() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _policeReportFile = pickedFile;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('4 - Policijsko poročilo'),
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
              // ✅ Upload Police Report
              const Text(
                "Upload Police Report (Optional)",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    icon: const Icon(Icons.upload_file),
                    label: const Text("Upload Report"),
                    onPressed: _pickReportFile,
                  ),
                ],
              ),

              // ✅ Show uploaded file preview
              if (_policeReportFile != null)
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text("Selected File: ${_policeReportFile!.name}"),
                ),

              const SizedBox(height: 16),

              // ✅ Enter Report Number
              const Text(
                "Report Number (Optional)",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Enter Report Number",
                ),
                onChanged: (value) => setState(() => _reportNumber = value),
              ),

              const SizedBox(height: 20),

              // ✅ Continue Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      LoadingOverlay.show(context); // ✅ Show loader

                      await Future.delayed(const Duration(milliseconds: 500)); // ✅ Brief delay

                      LoadingOverlay.hide(); // ✅ Hide loader before navigating

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Police Report Saved!')),
                      );

                      // ✅ Navigate to SubmitClaimPage
                      await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SubmitClaimPage()),
                      );

                      // ✅ After submitting, return to Home and remove all previous routes
                      await Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const HomePage()),
                            (route) => false, // Removes all previous routes
                      );
                    }
                  },


                  child: const Text('Next'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
