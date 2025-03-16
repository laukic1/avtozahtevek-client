import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // ✅ For image selection
import 'dart:io';
import 'package:my_app/claims/people_witnesses_page.dart';
import 'package:my_app/widgets/loading_overlay.dart';

class VehicleDamagePage extends StatefulWidget {
  const VehicleDamagePage({super.key});

  @override
  _VehicleDamagePageState createState() => _VehicleDamagePageState();
}

class _VehicleDamagePageState extends State<VehicleDamagePage> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedVehicle;
  List<XFile>? _damageImages = [];
  final ImagePicker _picker = ImagePicker();
  String _damageDescription = "";

  // ✅ Vehicle List (Replace with API data later)
  final List<String> _vehicles = [
    "Toyota Corolla 2022",
    "Honda Civic 2021",
    "Ford Focus 2020",
  ];

  // ✅ Select Image (Camera or Gallery)
  Future<void> _pickImage(ImageSource source) async {
    final List<XFile>? pickedImages = await _picker.pickMultiImage();
    if (pickedImages != null && pickedImages.isNotEmpty) {
      setState(() {
        _damageImages!.addAll(pickedImages);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('2 - Škoda vpletenih vozil'),
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
              // ✅ Select Vehicle
              const Text("Select Vehicle", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(border: OutlineInputBorder()),
                value: _selectedVehicle,
                items: _vehicles.map((String vehicle) {
                  return DropdownMenuItem<String>(
                    value: vehicle,
                    child: Text(vehicle),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedVehicle = value;
                  });
                },
                validator: (value) => value == null ? 'Please select a vehicle' : null,
              ),
              const SizedBox(height: 20),

              // ✅ Upload Damage Photos
              const Text("Upload Damage Photos", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.camera_alt, size: 40, color: Colors.blue),
                    onPressed: () => _pickImage(ImageSource.camera),
                  ),
                  const SizedBox(width: 20),
                  IconButton(
                    icon: const Icon(Icons.photo_library, size: 40, color: Colors.green),
                    onPressed: () => _pickImage(ImageSource.gallery),
                  ),
                ],
              ),

              // ✅ Show Uploaded Images
              if (_damageImages!.isNotEmpty)
                SizedBox(
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _damageImages!.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Image.file(
                          File(_damageImages![index].path),
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                ),

              const SizedBox(height: 20),

              // ✅ Describe the Damage
              const Text("Describe the Damage", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Briefly describe the damage',
                ),
                maxLines: 3,
                onChanged: (value) {
                  setState(() {
                    _damageDescription = value;
                  });
                },
                validator: (value) => value == null || value.isEmpty ? 'Please describe the damage' : null,
              ),

              const SizedBox(height: 20),

              // ✅ Continue Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_pickImage == null) {
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
                      MaterialPageRoute(builder: (context) => const PeopleWitnessesPage()),
                    );
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
