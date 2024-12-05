
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
  final TextEditingController _dateHourOccurrenceController =
  TextEditingController();
  final TextEditingController _dateHourReportedController =
  TextEditingController();
  final TextEditingController _informerNameController = TextEditingController();
  final TextEditingController _descriptionOffenseController =
  TextEditingController();
  final TextEditingController _placeOccurrenceController =
  TextEditingController();
  final TextEditingController _criminalNameController =
  TextEditingController();
  final TextEditingController _investigationStepsController =
  TextEditingController();
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
        Uri.parse('http://192.168.29.133:8000/generate-fir'), // Replace with your FastAPI endpoint
        headers: {'Content-Type': 'application/json'},
        body: json.encode(firDetails),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final fileName = responseData['download_url'];

        // Show success message and download link
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("FIR Generated Successfully"),
            content: Text("Download your FIR report: $fileName"),
            actions: [
              TextButton(
                onPressed: () async {
                  // Launch the URL to download the PDF
                  final downloadUrl = 'http://your-api-url-here/generate-fir/download/$fileName';
                  if (await canLaunch(downloadUrl)) {
                    await launch(downloadUrl);
                  } else {
                    throw 'Could not launch $downloadUrl';
                  }
                },
                child: Text('Download'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Close'),
              ),
            ],
          ),
        );
      } else {
        throw Exception('Failed to generate FIR');
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Error"),
          content: Text(e.toString()),
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
    } finally {
      setState(() {
        isLoading = false;
      });
    }
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
              TextFormField(
                controller: _bookNoController,
                decoration: InputDecoration(labelText: 'Book No.'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Book No.';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _formNoController,
                decoration: InputDecoration(labelText: 'Form No.'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Form No.';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _policeStationController,
                decoration: InputDecoration(labelText: 'Police Station'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Police Station';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _districtController,
                decoration: InputDecoration(labelText: 'District'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter District';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _dateHourOccurrenceController,
                decoration: InputDecoration(labelText: 'Date and Hour of Occurrence'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Date and Hour of Occurrence';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _dateHourReportedController,
                decoration: InputDecoration(labelText: 'Date and Hour Reported'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Date and Hour Reported';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _informerNameController,
                decoration: InputDecoration(labelText: 'Informer Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Informer Name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionOffenseController,
                decoration: InputDecoration(labelText: 'Brief Description of Offense'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Brief Description of Offense';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _placeOccurrenceController,
                decoration: InputDecoration(labelText: 'Place of Occurrence'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Place of Occurrence';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _criminalNameController,
                decoration: InputDecoration(labelText: 'Criminal Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Criminal Name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _investigationStepsController,
                decoration: InputDecoration(labelText: 'Investigation Steps'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Investigation Steps';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _dispatchTimeController,
                decoration: InputDecoration(labelText: 'Dispatch Time'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Dispatch Time';
                  }
                  return null;
                },
              ),
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
}
