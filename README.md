# JSON Form

[![Pub Version](https://img.shields.io/pub/v/json_form)](https://pub.dev/packages/json_form)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/rnp0728/json_form/blob/main/LICENSE)

JSON Form is a Flutter package that simplifies the process of generating dynamic forms based on JSON input. With JSON Form, you can easily create forms with various field types, validation rules, and input formatters.

## Features

- Dynamically generate forms from JSON configuration.
- Supports different field types: text, dropdown, date, time.
- Define labels, required fields, and custom validation rules in the JSON configuration.
- Custom input formatters for data transformation.

## Getting Started

### Installation

To use JSON Form in your Flutter project, add it to your `pubspec.yaml`:

```yaml
dependencies:
  json_form: ^x.x.x
```

### Usage

To get started with JSON Form, follow these steps:

Import the JSON Form package:

```dart
import 'package:json_form/json_form.dart';
```

Create a JSON configuration for your form:

```dart
final jsonConfig = {
  'firstname': {
    'type': 'text', // text or dropdown or date or time 
    'label': 'First Name',
    'required': true,
    'errorMsg': 'Please enter first name'.
    'regex': '', // Add your validation rules here.
  },
  // Add more fields as needed.
};

```

Build the form using the JSON configuration:

```dart
Widget buildForm() {
  return JsonForm(
    json: jsonConfig,
    onSaveChanges: (dynamic data){

    },
    // Add any custom form options here.
  );
}

```

Customize and style your form as needed.

### Configuration

You can customize your form's appearance and behavior by passing various options to the JsonForm widget. Check the documentation for available customization options.

### Example

For a detailed example of how to use JSON Form, check out the example folder in the package repository.

### Contributing

If you'd like to contribute to this package, please follow these guidelines:

### Fork the repository

Create a new branch for your feature or bugfix.
Write tests for your code.
Implement your feature or fix the bug.
Run the tests.
Submit a pull request.

### Issues

If you find any issues or have suggestions, please open an issue here.

### License

This package is released under the MIT License. See LICENSE for more details.

### Author

JSON Form is maintained by Rudra Narayan Panda. Feel free to reach out for any questions or assistance.

Happy coding!
