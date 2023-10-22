import 'package:intl/intl.dart';
import 'package:json_form/json_form.dart';
import 'package:json_form/src/helpers/helpers.dart';
import 'package:json_form/src/theme/theme.dart';
import 'package:json_form/src/widgets/custom_dropdown.dart';
import 'package:json_form/src/widgets/custom_text_form_field.dart';
import 'package:json_form/src/widgets/editable_string_list.dart';
import 'package:json_form/src/widgets/responsive_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

enum FieldType {
  text, // done
  date, // done
  time, // todo
  multiSelect, // todo
  radioOption, // todo
  dropdown, // done
  multiText, // todo
}

class CustomFormField {
  static Widget formField({
    BuildContext? context,
    required LayoutType layout,
    required FieldType fieldType,
    required String label,
    required String? initialValue,
    required void Function(dynamic val) onChanged,
    String? Function(String?)? validator,
    TextInputType? textInputType,
    List<TextInputFormatter>? inputFormatters,
    bool readOnly = false,
    int maxLines = 1,
    int? maxLength,
    Widget? prefix,
    bool isDateField = true,
    TextEditingController? controller,
    bool obscureText = false,
    Function(String)? onFieldSubmitted,
    AutovalidateMode autovalidateMode = AutovalidateMode.onUserInteraction,
    Iterable<String>? autofillHints,
    MouseCursor? mouseCursor,
    InputDecoration? decorator,
    bool autofocus = false,
    FocusNode? focusNode,
    bool? enabled,
    Function()? onEditingComplete,
    String? userAuthToken,
    List<String> dropdownOptions = const [],
    String? Function(dynamic)? dropdownValidator,
    List<String>? editableStringItems,
    void Function(List<String>)? updateListInState,
    Map<String, dynamic> multiSelectOptions = const {},
    List<String>? multiSelectFieldItems,
    void Function(List<dynamic> selectedItems)? onMultiSelectChanged,
    bool prevDateRestriction = false,
    bool futureDateRestriction = false,
    BorderRadius? borderRadius,
    TextAlign? textAlign,
    // width
    double widthX5 = 369,
    double widthX4 = 296,
    double widthX3 = 276,
    double widthX2 = 246,
  }) {
    TextEditingController? textEditingController;
    if (controller == null) {
      textEditingController = TextEditingController(text: initialValue);
    }
    var formField = CustomTextFormField(
      label: label,
      autofocus: autofocus,
      textAlign: textAlign ?? TextAlign.start,
      autovalidateMode: autovalidateMode,
      controller: initialValue == null ? textEditingController : null,
      decorator: decorator,
      enabled: enabled,
      focusNode: focusNode,
      initialValue: initialValue,
      inputFormatters: inputFormatters,
      maxLength: maxLength,
      maxLines: maxLines,
      onFieldSubmitted: onFieldSubmitted,
      onEditingComplete: onEditingComplete,
      obscureText: obscureText,
      prefix: prefix,
      readOnly: readOnly,
      textInputType: textInputType,
      validator: validator ?? (value) => null,
      borderRadius: borderRadius ?? BorderRadius.circular(10.58),
      onChanged: onChanged,
    );

    switch (fieldType) {
      case FieldType.text:
        return MyResponsiveContainer(
          layout: layout,
          widthX5: widthX5,
          widthX4: widthX4,
          widthX3: widthX3,
          widthX2: widthX2,
          child: formField,
        );
      case FieldType.time:
        return MyResponsiveContainer(
          layout: layout,
          widthX5: widthX5,
          widthX4: widthX4,
          widthX3: widthX3,
          widthX2: widthX2,
          child: SizedBox(
            width: double.infinity,
            child: (formField).copyWith(
              initialValue: null,
              controller: textEditingController,
              isTimeField: true,
              textInputType: TextInputType.datetime,
              readOnly: true,
              onTap: () async {
                TimeOfDay? updatedTime = await showTimePicker(
                  context: context!,
                  initialTime: TimeOfDay.now(),
                  builder: (context, child) {
                    return Theme(
                      data: Theme.of(context).copyWith(
                        colorScheme: ColorScheme.light(
                          primary: JsonFormTheme.focusColor,
                          onPrimary: JsonFormTheme.white,
                          onSurface: JsonFormTheme.black,
                        ),
                      ),
                      child: child!,
                    );
                  },
                );

                if (updatedTime != null) {
                  // ignore: use_build_context_synchronously
                  String parsedTime = updatedTime.format(context);
                  controller?.text = parsedTime;
                  onChanged(parsedTime);
                }
              },
              focusNode: focusNode,
              onFieldSubmitted: onFieldSubmitted,
              obscureText: obscureText,
              maxLines: maxLines,
              autovalidateMode: autovalidateMode,
              validator: validator,
              onChanged: onChanged,
              onEditingComplete: onEditingComplete,
            ),
          ),
        );
      case FieldType.date:
        return MyResponsiveContainer(
          layout: layout,
          widthX5: widthX5,
          widthX4: widthX4,
          widthX3: widthX3,
          widthX2: widthX2,
          child: SizedBox(
            width: double.infinity,
            child: (formField).copyWith(
              initialValue: null,
              isDateField: isDateField,
              controller: textEditingController,
              textInputType: TextInputType.datetime,
              onTap: () async {
                DateTime? updatedDate = await showDatePicker(
                  context: context!,
                  locale: const Locale('en', 'IN'),
                  initialDate: initialValue != null && (initialValue.isNotEmpty)
                      ? DateTime.parse(convertDate(initialValue))
                      : DateTime.now(),
                  firstDate:
                      prevDateRestriction ? DateTime.now() : DateTime(1900),
                  lastDate:
                      futureDateRestriction ? DateTime.now() : DateTime(2100),
                  builder: (context, child) {
                    return Theme(
                      data: Theme.of(context).copyWith(
                        colorScheme: ColorScheme.light(
                            primary: JsonFormTheme.focusColor,
                          onPrimary: JsonFormTheme.white,
                          onSurface: JsonFormTheme.black,
                            ),
                      ),
                      child: child!,
                    );
                  },
                );

                if (updatedDate != null) {
                  String parsedDate =
                      DateFormat('dd-MM-yyyy').format(updatedDate);
                  controller?.text = parsedDate;
                  print('here');
                  onChanged(parsedDate);
                }
              },
              focusNode: focusNode,
              onFieldSubmitted: onFieldSubmitted,
              obscureText: obscureText,
              maxLines: maxLines,
              autovalidateMode: autovalidateMode,
              validator: validator,
              onChanged: onChanged,
              onEditingComplete: onEditingComplete,
            ),
          ),
        );
      case FieldType.dropdown:
        return MyResponsiveContainer(
          layout: layout,
          widthX5: widthX5,
          widthX4: widthX4,
          widthX3: widthX3,
          widthX2: widthX2,
          child: CustomDropDown(
            label: label,
            onChanged: (val) {
              onChanged(val ?? dropdownOptions[0]);
            },
            value: (initialValue == '' || initialValue == null)
                ? null
                : initialValue,
            validator: dropdownValidator,
            items: [
              for (String val in dropdownOptions)
                DropdownMenuItem(
                  value: val,
                  child: SizedBox(
                    child: Text(
                      val,
                      style: TextStyle(
                        fontSize: 16,
                        color: JsonFormTheme.black,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      case FieldType.radioOption:
        bool? radioVal = initialValue == null
            ? null
            : initialValue == "true"
                ? true
                : false;
        return Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 15.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 16.0,
                width: 16.0,
                child: Radio(
                  value: true,
                  groupValue: radioVal,
                  activeColor: JsonFormTheme.green,
                  onChanged: (value) {
                    radioVal = true;
                    onChanged(
                      radioVal.toString(),
                    );
                  },
                ),
              ),
              const SizedBox(
                width: 10.0,
              ),
              Text(
                'Yes',
                style: TextStyle(
                  color: JsonFormTheme.black,
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),
              const SizedBox(
                width: 50.0,
              ),
              SizedBox(
                height: 16.0,
                width: 16.0,
                child: Radio(
                  value: false,
                  groupValue: radioVal,
                  activeColor: JsonFormTheme.green,
                  onChanged: (value) {
                    radioVal = false;
                    onChanged(
                      radioVal.toString(),
                    );
                  },
                ),
              ),
              const SizedBox(
                width: 10.0,
              ),
              Text(
                'No',
                style: TextStyle(
                  color: JsonFormTheme.black,
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        );
      case FieldType.multiText:
        return MyResponsiveContainer(
          layout: layout,
          widthX5: widthX5,
          widthX4: widthX4,
          widthX3: widthX3,
          widthX2: widthX2,
          child: SizedBox(
            width: double.infinity,
            child: EditableStringList(
              label: label,
              stringList: editableStringItems ?? [],
              updateListInState: updateListInState ?? (value) {},
              validator: validator ?? (value) => null,
              saveValidator: (value) => null,
            ),
          ),
        );
      case FieldType.multiSelect:
        String? hintText = label;

        List<MultiSelectItem<String>> multiSelectItems = [];
        multiSelectOptions.forEach((key, value) {
          multiSelectItems.add(
            MultiSelectItem<String>(value, key),
          );
        });
        return MyResponsiveContainer(
          layout: layout,
          widthX5: widthX5,
          widthX4: widthX4,
          widthX3: widthX3,
          widthX2: widthX2,
          child: SizedBox(
            width: double.infinity,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.58),
                border: Border.all(
                  width: 1.25,
                  color: JsonFormTheme.focusColor,
                ),
              ),
              child: MultiSelectDialogField<String>(
                items: multiSelectItems,
                buttonText: Text(hintText),
                title: Text('Select $hintText'),
                buttonIcon: const Icon(Icons.arrow_drop_down_outlined),
                listType: MultiSelectListType.CHIP,
                initialValue: multiSelectFieldItems?.toList() ?? [],
                onConfirm: onMultiSelectChanged ?? (items) {},
              ),
            ),
          ),
        );
      default:
        return Container();
    }
  }
}
