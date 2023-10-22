import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:json_to_forms/src/cubit/json_form_cubit.dart';
import 'package:json_to_forms/src/theme/theme.dart';
import 'package:json_to_forms/src/view/form_fields.dart';

enum LayoutType { x5, x4, x3, x2, x1 }

class JsonForm extends StatefulWidget {
  final Color backgroundColor;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Map<String, dynamic> json;
  // sample format - {
  //   'firstname': {
  //     'type': 'text', // text / dropdown / date / time
  //     'label': 'First Name',
  //     'required': true, // validation
  //     'regex': '', // as input formatter
  //   },
  // },
  final bool isMultiForm;
  final Function(dynamic data) onSaveChanges;
  final Alignment buttonAlignment;
  final bool cleanAfterSave;
  const JsonForm({
    super.key,
    required this.json,
    this.backgroundColor = Colors.white,
    this.borderRadius,
    this.padding,
    this.margin,
    this.isMultiForm = false,
    required this.onSaveChanges,
    this.cleanAfterSave = true,
    this.buttonAlignment = Alignment.bottomCenter,
  });

  @override
  State<JsonForm> createState() => _JsonFormState();
}

class _JsonFormState extends State<JsonForm> {
  LayoutType layout = LayoutType.x1;
  void setParameters(double width) {
    if (width > 1200) {
      layout = LayoutType.x5;
    } else if (width > 992) {
      layout = LayoutType.x4;
    } else if (width > 768) {
      layout = LayoutType.x3;
    } else if (width > 576) {
      layout = LayoutType.x2;
    } else {
      layout = LayoutType.x1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, contraints) {
      setParameters(contraints.maxWidth);
      return BlocProvider(
        create: (context) => JsonFormCubit(
          formData: widget.json,
        )..initialFormSetup(),
        child: BlocBuilder<JsonFormCubit, JsonFormState>(
          builder: (context, state) {
            var cubit = context.read<JsonFormCubit>();
            return Container(
              padding: widget.padding,
              margin: widget.margin,
              decoration: BoxDecoration(
                color: widget.backgroundColor,
                borderRadius: widget.borderRadius,
              ),
              child: Column(
                children: [
                  ...state.forms.map((e) {
                    var index = state.forms.indexOf(e);
                    return FormFields(
                      key: Key(e.toString()),
                      layout: layout,
                      formData: e,
                      index: index,
                      showButtons: widget.isMultiForm,
                    );
                  }),
                  Container(
                    alignment: widget.buttonAlignment,
                    padding: const EdgeInsets.symmetric(
                      vertical: 16.0,
                      horizontal: 16.0,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        List<dynamic> data = [];
                        List<bool> allValidated = [];
                        for (int i = 0; i < state.forms.length; i++) {
                          allValidated.add(state
                              .forms[i]['formKey'].currentState!
                              .validate());
                        }
                        if (allValidated.contains(false)) {
                          return;
                        }
                        for (int i = 0; i < state.forms.length; i++) {
                          if (state.forms[i]['storage'].isNotEmpty) {
                            data.add(state.forms[i]['storage']);
                          }
                        }
                        if (widget.cleanAfterSave) {
                          cubit.cleanUp();
                        }
                        // if (kDebugMode) {
                        //   print(data);
                        // }
                        widget
                            .onSaveChanges(widget.isMultiForm ? data : data[0]);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(
                          vertical: 16.0,
                          horizontal: 12.0,
                        ),
                        constraints: const BoxConstraints(
                          maxWidth: 140,
                        ),
                        decoration: BoxDecoration(
                          color: JsonFormTheme.green.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text(
                          'Save Changes',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
    });
  }
}
