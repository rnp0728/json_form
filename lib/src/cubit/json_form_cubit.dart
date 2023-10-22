
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

part 'json_form_state.dart';

class JsonFormCubit extends Cubit<JsonFormState> {
  final Map<String, dynamic> formData;
  JsonFormCubit({required this.formData}) : super(const JsonFormState());

  void initialFormSetup() async {
    var temp = Map<String, dynamic>.from(formData);
    temp['uuid'] = getUniqueID();
    if (!temp.containsKey('storage')) {
      temp['storage'] = {};
    }
    temp['formKey'] = GlobalKey<FormState>();
    emit(
      state.copyWith(forms: [temp], formState: MyFormState.success),
    );
  }

  void update(JsonFormState updatedState) {
    emit(updatedState);
  }

  Future<void> addForm({required int index}) async {
    var temp = Map<String, dynamic>.from(formData);
    emit(state.copyWith(formState: MyFormState.loading));
    temp['uuid'] = getUniqueID();
    if (!temp.containsKey('storage')) {
      temp['storage'] = {};
    }
    temp['formKey'] = GlobalKey<FormState>();
    state.forms.insert(index + 1, temp);

    emit(
      state.copyWith(
        forms: state.forms,
        formState: MyFormState.success,
      ),
    );
  }

  Future<void> removeForm({
    required int index,
    required String key,
  }) async {
    emit(state.copyWith(formState: MyFormState.loading));
    state.forms.removeWhere((e) => e['uuid'] == key);
    emit(
      state.copyWith(
        forms: state.forms,
        formState: MyFormState.success,
      ),
    );
  }

  void cleanUp() {
    emit(state.copyWith(formState: MyFormState.loading));
    initialFormSetup();
  }

  String getUniqueID() {
    Uuid uuid = const Uuid();
    return uuid.v4().toString();
  }
}
