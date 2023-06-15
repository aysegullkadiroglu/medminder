class Medicine {
  final List<dynamic>? notificationIDs;
  final String? medicineName;
  final String? medicineDetail;
  final String? medicineType;
  final int? dosage;
  final int? medicineStock;
  final int? medicineUsage;

  Medicine(
      {this.notificationIDs,
        this.medicineName,
        this.medicineDetail,
        this.medicineType,
        this.dosage,
        this.medicineStock,
      this.medicineUsage});

  // getters
  List<dynamic> get getIDs => notificationIDs!;
  String get getName => medicineName!;
  String get getDetail => medicineDetail!;
  String get getType => medicineType!;
  int get getDosage => dosage!;
  int get getStock => medicineStock!;
  int get getUsage => medicineUsage!;

  Map<String, dynamic> toJson() {
    return {
      'ids': notificationIDs,
      'name': medicineName,
      'detail': medicineDetail,
      'type': medicineType,
      'dosage': dosage,
      'stock': medicineStock,
      'usage': medicineUsage,
    };
  }

  factory Medicine.fromJson(Map<String, dynamic> parsedJson) {
    return Medicine(
      notificationIDs: parsedJson['ids'],
      medicineName: parsedJson['name'],
      medicineDetail: parsedJson['detail'],
      medicineType: parsedJson['type'],
      dosage: parsedJson['dosage'],
      medicineStock: parsedJson['stock'],
      medicineUsage: parsedJson['usage'],
    );
  }
}