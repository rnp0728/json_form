import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:json_to_forms/json_to_forms.dart';
import 'package:json_to_forms/src/cubit/json_form_cubit.dart';
import 'package:json_to_forms/src/helpers/helpers.dart';
import 'package:json_to_forms/src/theme/theme.dart';
import 'package:json_to_forms/src/widgets/custom_form_field.dart';

class FormFields extends StatefulWidget {
  final Map<String, dynamic> formData;
  final int index;
  final LayoutType layout;
  final bool showButtons;
  const FormFields(
      {super.key,
      required this.layout,
      required this.formData,
      required this.index,
      required this.showButtons});

  @override
  State<FormFields> createState() => _FormFieldsState();
}

class _FormFieldsState extends State<FormFields> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<JsonFormCubit, JsonFormState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 10.0,
          ),
          child: ListView(
            shrinkWrap: true,
            children: [
              Form(
                key: widget.formData['formKey'],
                child: Wrap(
                  runSpacing: 20,
                  spacing: 10,
                  children: [
                    ...getFormFields(widget.formData),
                  ],
                ),
              ),
              if (widget.showButtons)
                Container(
                  alignment: Alignment.bottomRight,
                  margin: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          context
                              .read<JsonFormCubit>()
                              .addForm(index: widget.index);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 8.0,
                          ),
                          decoration: BoxDecoration(
                              color: JsonFormTheme.green.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(10)),
                          child: const Icon(
                            Icons.add,
                            size: 30,
                          ),
                        ),
                      ),
                      10.width,
                      if (state.forms.length > 1)
                        GestureDetector(
                          onTap: () {
                            context.read<JsonFormCubit>().removeForm(
                                  index: widget.index,
                                  key: widget.formData['uuid'],
                                );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 8.0,
                              horizontal: 8.0,
                            ),
                            decoration: BoxDecoration(
                                color: JsonFormTheme.green.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(10)),
                            child: const Icon(
                              Icons.remove,
                              size: 30,
                            ),
                          ),
                        )
                    ],
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  List<Widget> getFormFields(Map<String, dynamic> map) {
    List<Widget> fieldList = [];
    map.forEach((key, value) {
      if (key != 'uuid' && key != 'storage' && key != 'formKey') {
        fieldList.add(getField(value['type'], key, value, map));
      }
    });
    return fieldList;
  }

  Widget getField(
    String type,
    String key,
    dynamic value,
    Map<String, dynamic> completeMap,
  ) {
    switch (type) {
      case 'text':
        return StatefulBuilder(
          builder: (context, changeState) {
            return CustomFormField.formField(
              layout: widget.layout,
              context: context,
              fieldType: FieldType.text,
              label: value['label'],
              inputFormatters: [
                if (value['regex'] is! String?)
                  FilteringTextInputFormatter.allow(RegExp(value['regex']))
              ],
              initialValue: completeMap['storage'][key],
              onChanged: (val) {
                changeState(
                  () => completeMap['storage'][key] = val,
                );
              },
              validator: (val) {
                if ((value['required'] ?? false) &&
                    (val == null || val.isEmpty)) {
                  return value['errorMsg'] ?? 'Required Field';
                }
                return null;
              },
            );
          },
        );
      case 'dropdown':
        return StatefulBuilder(
          builder: (context, changeState) {
            return CustomFormField.formField(
              layout: widget.layout,
              context: context,
              fieldType: FieldType.dropdown,
              label: value['label'],
              inputFormatters: [],
              dropdownOptions: value['options'],
              dropdownValidator: (val) {
                if ((value['required'] ?? false) &&
                    (val == null || val.isEmpty)) {
                  return value['errorMsg'] ?? 'Required Field';
                }
                return null;
              },
              initialValue: completeMap['storage'][key],
              onChanged: (val) {
                // completeMap['storage'][key] = val;
                changeState(
                  () => completeMap['storage'][key] = val,
                );
              },
            );
          },
        );
      case 'date':
        return StatefulBuilder(
          builder: (context, changeState) {
            return CustomFormField.formField(
                layout: widget.layout,
                context: context,
                fieldType: FieldType.date,
                label: value['label'],
                readOnly: true,
                initialValue: completeMap['storage'][key],
                onChanged: (val) {
                  changeState(
                    () => completeMap['storage'][key] = val,
                  );
                },
                validator: (val) {
                  if ((value['required'] ?? false) &&
                      (val == null || val.isEmpty)) {
                    return value['errorMsg'] ?? 'Required Field';
                  }
                  return null;
                });
          },
        );
      case 'time':
        return StatefulBuilder(
          builder: (context, changeState) {
            return CustomFormField.formField(
                layout: widget.layout,
                context: context,
                fieldType: FieldType.time,
                label: value['label'],
                readOnly: true,
                initialValue: completeMap['storage'][key],
                onChanged: (val) {
                  changeState(
                    () => completeMap['storage'][key] = val,
                  );
                },
                validator: (val) {
                  if ((value['required'] ?? false) &&
                      (val == null || val.isEmpty)) {
                    return value['errorMsg'] ?? 'Required Field';
                  }
                  return null;
                });
          },
        );
      default:
        return CustomFormField.formField(
          layout: widget.layout,
          context: context,
          fieldType: FieldType.text,
          label: value['label'],
          initialValue: completeMap['storedData'][key],
          onChanged: (val) {
            completeMap['storage'][key] = val;
          },
          validator: (val) {
            return null;
          },
        );
    }
  }
}
