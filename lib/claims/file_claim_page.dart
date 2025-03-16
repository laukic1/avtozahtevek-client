import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart'; // ✅ Ensure intl is initialized
import 'package:intl/intl.dart';
import 'package:my_app/claims/vehicle_damage_page.dart';
import 'package:my_app/profile/support_page.dart';
import 'package:my_app/widgets/loading_overlay.dart';

class FileClaimPage extends StatefulWidget {
  const FileClaimPage({super.key});

  @override
  _FileClaimPageState createState() => _FileClaimPageState();
}

class _FileClaimPageState extends State<FileClaimPage> {
  final _formKey = GlobalKey<FormState>();

  String _incidentDescription = "";
  DateTime? _incidentDate;
  TimeOfDay? _incidentTime;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting(); // ✅ Ensures intl formats are loaded
  }

  // ✅ Show Cupertino Time Picker (iOS Style)
  void _showCupertinoTimePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          height: 250,
          child: CupertinoTimerPicker(
            mode: CupertinoTimerPickerMode.hm,
            initialTimerDuration: Duration(
              hours: _incidentTime?.hour ?? TimeOfDay.now().hour,
              minutes: _incidentTime?.minute ?? TimeOfDay.now().minute,
            ),
            onTimerDurationChanged: (Duration newTime) {
              setState(() {
                _incidentTime = TimeOfDay(hour: newTime.inHours, minute: newTime.inMinutes % 60);
              });
            },
          ),
        );
      },
    );
  }

  // ✅ Show Date Picker
  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _incidentDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null && pickedDate != _incidentDate) {
      setState(() {
        _incidentDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('1 - Informacije o nezgodi'),
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
              // ✅ Incident Date Picker (Fixed)
              ListTile(
                title: Text(
                  _incidentDate == null
                      ? 'Select Incident Date'
                      : 'Date: ${DateFormat('yyyy-MM-dd').format(_incidentDate!)}', // ✅ Fixed intl bug
                  style: const TextStyle(fontSize: 16),
                ),
                trailing: const Icon(Icons.calendar_today),
                onTap: () => _selectDate(context),
              ),
              const SizedBox(height: 16),

              // ✅ Incident Time Picker (Cupertino)
              ListTile(
                title: Text(
                  _incidentTime == null
                      ? 'Select Incident Time'
                      : 'Time: ${_incidentTime!.format(context)}',
                  style: const TextStyle(fontSize: 16),
                ),
                trailing: const Icon(Icons.access_time),
                onTap: () => _showCupertinoTimePicker(context),
              ),
              const SizedBox(height: 16),

              // ✅ Incident Description
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Describe the Incident',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                onChanged: (value) {
                  setState(() {
                    _incidentDescription = value;
                  });
                },
              ),
              const SizedBox(height: 20),

              // ✅ "Next" Button (Moves to Step 2)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_incidentDate == null) {
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
                      MaterialPageRoute(builder: (context) => const VehicleDamagePage()),
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
