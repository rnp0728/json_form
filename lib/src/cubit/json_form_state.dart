part of 'json_form_cubit.dart';

enum MyFormState {
  init,
  loading,
  success,
  error,
}

class JsonFormState extends Equatable {
  final List<Map<String, dynamic>> forms;
  final MyFormState formState;

  const JsonFormState({
    this.forms = const [],
    this.formState = MyFormState.init,
  });

  @override
  List<Object?> get props => [
        forms,
        formState,
      ];

  JsonFormState copyWith({
    List<Map<String, dynamic>>? forms,
    MyFormState? formState,
  }) {
    return JsonFormState(
      forms: forms ?? this.forms,
      formState: formState ?? this.formState,
    );
  }
}
