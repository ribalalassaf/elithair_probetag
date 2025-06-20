import 'package:auto_route/auto_route.dart';
import 'package:elithair_probetag/config/injectable.dart';
import 'package:elithair_probetag/features/medical_form_feature/business_logic/controller/records_cubit/records_cubit.dart';
import 'package:elithair_probetag/features/medical_form_feature/model/form_model.dart';
import 'package:elithair_probetag/features/medical_form_feature/widgets/custom_date_picker.dart';
import 'package:elithair_probetag/features/medical_form_feature/widgets/custom_drop_down.dart';
import 'package:elithair_probetag/features/medical_form_feature/widgets/custom_text_field.dart';
import 'package:elithair_probetag/utils/extensions.dart';
import 'package:elithair_probetag/utils/validators.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

@RoutePage()
class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  FormModel model = FormModel();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<RecordsCubit>(),
      child: Scaffold(
        appBar: AppBar(title: Text("Medical history form")),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),

            child: Form(
              key: _formKey,
              child: Column(
                spacing: 17,
                children: [
                  FormField<List<String>>(
                    initialValue: model.conditions,
                    validator: (value) {
                      if (value.isEmptyOrNull()) return "This can't be empty";
                      return null;
                    },
                    builder: (field) {
                      return FormErrorWidget(
                        message: field.errorText ?? "",
                        hasError: field.hasError,
                        child: MultiSelectDropdown(
                          values: ["Condition 1", "Condition 2", "Condition 3"],
                          onChanged: (value) {
                            setState(() {
                              model.conditions = value;
                            });
                            field.didChange(model.conditions);
                          },
                          initialSelected: model.conditions ?? [],

                          hintText: "Conditions",
                        ),
                      );
                    },
                  ),

                  CustomTextFormField(
                    validator: (value) => RequiredValidator(value: value!).validate(),
                    hintText: "Medications",
                    onChanged: (value) {
                      model.medications = value;
                    },
                  ),
                  CustomTextFormField(
                    hintText: "Allergies",
                    onChanged: (value) {
                      model.allergies = value;
                    },
                  ),

                  FormField(
                    initialValue: model.priorTransplant,
                    validator: (value) {
                      if (value == null) return "field_required";
                      return null;
                    },
                    builder: (field) {
                      return FormErrorWidget(
                        message: field.errorText ?? "",
                        hasError: field.hasError,
                        child: CustomDropDown<String>(
                          values: ["Yes", "No"],
                          onChange: (value) {
                            setState(() {
                              model.priorTransplant = value == "Yes";
                            });
                            field.didChange(model.priorTransplant);
                          },
                          initialValue: null,
                          hintText: "Has done transplants",
                        ),
                      );
                    },
                  ),
                  if (model.priorTransplant != null && model.priorTransplant == true)
                    CustomTextFormField(
                      hintText: "Transplant Date",
                      validator: (value) => RequiredValidator(value: value!).validate(),
                      value: model.transplantDate != null ? DateFormat("yyyy.MM.dd").format(model.transplantDate!) : "",
                      readOnly: true,
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => CustomDatePicker(
                            selectionMode: DateRangePickerSelectionMode.single,
                            enablePastDates: true,
                            withSaveButton: false,
                            onDateChange: (date) {
                              setState(() {
                                model.transplantDate = date;
                              });
                            },
                          ),
                        );
                      },
                    ),
                  TextButton(
                    onPressed: () async {
                      FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true);

                      if (result != null) {
                        setState(() {
                          model.documents = result.paths.map((path) => path!).toList();
                        });
                      }
                    },
                    child: Text("Add files"),
                  ),
                  if (!model.documents.isEmptyOrNull())
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            spacing: 10,
                            children: model.documents?.map<Widget>((path) => Text(path)).toList() ?? [],
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              model.documents = [];
                            });
                          },
                          icon: Icon(Icons.delete),
                        ),
                      ],
                    ),
                  FormField<bool?>(
                    initialValue: model.signatureConfirmed,
                    validator: (value) {
                      if (value == null) return "field_required";
                      return null;
                    },

                    builder: (field) {
                      return FormErrorWidget(
                        message: field.errorText ?? "",
                        hasError: field.hasError,
                        child: Row(
                          children: [
                            Checkbox(
                              value: model.signatureConfirmed ?? false,
                              onChanged: (value) {
                                setState(() {
                                  model.signatureConfirmed = value;
                                });
                                field.didChange(model.signatureConfirmed);
                              },
                            ),
                            Text("Signature confirmed"),
                          ],
                        ),
                      );
                    },
                  ),
                  BlocConsumer<RecordsCubit, RecordsState>(
                    listener: (context, state) {
                      state.maybeWhen(
                        orElse: () {},
                        success: () {
                          context.maybePop();
                          Fluttertoast.showToast(msg: "Success");
                        },
                      );
                    },
                    builder: (context, state) {
                      return state.maybeWhen(
                        inProgress: () => CircularProgressIndicator(),
                        orElse: () => TextButton(
                          onPressed: () {
                            if (!_formKey.currentState!.validate()) return;
                            _formKey.currentState!.save();
                            context.read<RecordsCubit>().addRecord(model);
                          },
                          child: Text("Sumbit"),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class FormErrorWidget extends StatelessWidget {
  final Widget child;
  final String message;
  final bool hasError;
  const FormErrorWidget({super.key, required this.child, required this.message, this.hasError = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        child,
        if (hasError) Text(message, style: TextStyle(color: Colors.red)),
      ],
    );
  }
}
