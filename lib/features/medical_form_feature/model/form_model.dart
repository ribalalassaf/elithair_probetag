class FormModel {
  String? userId;
  List<String>? conditions;
  String? medications;
  String? allergies;
  bool? priorTransplant;
  DateTime? transplantDate;
  List<String>? documents;
  bool? signatureConfirmed;

  FormModel({
    this.userId,
    this.conditions,
    this.medications,
    this.allergies,
    this.priorTransplant,
    this.transplantDate,
    this.documents,
    this.signatureConfirmed,
  });

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "conditions": conditions == null ? [] : List<dynamic>.from(conditions!.map((x) => x)),
    "medications": medications,
    "allergies": allergies,
    "priorTransplant": priorTransplant,
    "transplantDate": transplantDate != null
        ? "${transplantDate!.year.toString().padLeft(4, '0')}-${transplantDate!.month.toString().padLeft(2, '0')}-${transplantDate!.day.toString().padLeft(2, '0')}"
        : null,
    "documents": documents == null ? [] : List<dynamic>.from(documents!.map((x) => x)),
    "signatureConfirmed": signatureConfirmed,
  };
}
