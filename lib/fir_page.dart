import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

class FirComponent extends StatefulWidget {
  @override
  _FirComponentState createState() => _FirComponentState();
}

class _FirComponentState extends State<FirComponent> {
  final _formKey = GlobalKey<FormState>();

  // FIR details form fields
  final TextEditingController _bookNoController = TextEditingController();
  final TextEditingController _formNoController = TextEditingController();
  final TextEditingController _policeStationController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _dateHourOccurrenceController = TextEditingController();
  final TextEditingController _dateHourReportedController = TextEditingController();
  final TextEditingController _informerNameController = TextEditingController();
  final TextEditingController _descriptionOffenseController = TextEditingController();
  final TextEditingController _placeOccurrenceController = TextEditingController();
  final TextEditingController _criminalNameController = TextEditingController();
  final TextEditingController _investigationStepsController = TextEditingController();
  final TextEditingController _dispatchTimeController = TextEditingController();

  bool isLoading = false;

  // Function to handle FIR generation request
  Future<void> generateFIR() async {
    setState(() {
      isLoading = true;
    });

    final firDetails = {
      "book_no": _bookNoController.text,
      "form_no": _formNoController.text,
      "police_station": _policeStationController.text,
      "district": _districtController.text,
      "date_hour_occurrence": _dateHourOccurrenceController.text,
      "date_hour_reported": _dateHourReportedController.text,
      "informer_name": _informerNameController.text,
      "description_offense": _descriptionOffenseController.text,
      "place_occurrence": _placeOccurrenceController.text,
      "criminal_name": _criminalNameController.text,
      "investigation_steps": _investigationStepsController.text,
      "dispatch_time": _dispatchTimeController.text,
    };

    try {
      final response = await http.post(
        Uri.parse('https://fir-generator.onrender.com/'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(firDetails),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final downloadUrl = responseData['download_url'];

        if (downloadUrl != null && Uri.parse(downloadUrl).isAbsolute) {
          final uri = Uri.parse(downloadUrl);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri, mode: LaunchMode.externalApplication);
          } else {
            _showErrorDialog('Could not open the download link. Copy the link manually:\n$downloadUrl');
          }

        } else {
          _showErrorDialog('Invalid download URL received. Please contact support.');
        }
      } else {
        throw Exception('Failed to generate FIR: ${response.reasonPhrase}');
      }
    } catch (e) {
      _showErrorDialog('Error occurred: ${e.toString()}');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  // Error Dialog Helper Function
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Error"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // Dispose controllers to prevent memory leaks
    _bookNoController.dispose();
    _formNoController.dispose();
    _policeStationController.dispose();
    _districtController.dispose();
    _dateHourOccurrenceController.dispose();
    _dateHourReportedController.dispose();
    _informerNameController.dispose();
    _descriptionOffenseController.dispose();
    _placeOccurrenceController.dispose();
    _criminalNameController.dispose();
    _investigationStepsController.dispose();
    _dispatchTimeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Generate FIR")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTextField(_bookNoController, 'Book No.'),
              _buildTextField(_formNoController, 'Form No.'),
              _buildTextField(_policeStationController, 'Police Station'),
              _buildTextField(_districtController, 'District'),
              _buildTextField(_dateHourOccurrenceController, 'Date and Hour of Occurrence'),
              _buildTextField(_dateHourReportedController, 'Date and Hour Reported'),
              _buildTextField(_informerNameController, 'Informer Name'),
              _buildTextField(_descriptionOffenseController, 'Brief Description of Offense'),
              _buildTextField(_placeOccurrenceController, 'Place of Occurrence'),
              _buildTextField(_criminalNameController, 'Criminal Name'),
              _buildTextField(_investigationStepsController, 'Investigation Steps'),
              _buildTextField(_dispatchTimeController, 'Dispatch Time'),
              SizedBox(height: 20),
              isLoading
                  ? Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    generateFIR();
                  }
                },
                child: Text("Generate FIR"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper Function to Build TextFields
  Widget _buildTextField(TextEditingController controller, String label) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: label),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        return null;
      },
    );
  }
}
