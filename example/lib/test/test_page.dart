import 'package:flutter/material.dart';
import 'package:json_form/json_form.dart';

class TestPage extends StatefulWidget {
  const TestPage({
    super.key,
  });

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.green,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            JsonForm(
              backgroundColor: Colors.white,
              borderRadius: BorderRadius.circular(10),
              padding: const EdgeInsets.all(10.0),
              margin: const EdgeInsets.all(10.0),
              isMultiForm: false,
              json: const {
                'firstname': {
                  'type': 'text', // text / dropdown
                  'label': 'First Name',
                  'required': true, // validation
                  'regex': '', // as input formatter
                },
                'gender': {
                  'type': 'dropdown', // text / dropdown
                  'label': 'Gender',
                  'options': ['Male', 'Female', 'Prefer not to Say'],
                  'required': true,
                },
                'date': {
                  'type': 'time', // text / dropdown
                  'label': 'Date',
                  'required': true,
                },
              },
              buttonAlignment: Alignment.bottomRight,
              onSaveChanges: (dynamic data) {
                print(data);
              },
            ),
          ],
        ),
      ),
    );
  }
}
