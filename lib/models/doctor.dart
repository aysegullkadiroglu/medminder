class Doctor {
  final String? doctorName;
  final int? phoneNumber;
  final String? department;

  Doctor(
      {this.doctorName,
        this.phoneNumber,
        this.department});

  // getters
  String get getDoctorName => doctorName!;
  int get getPhoneNumber => phoneNumber!;
  String get getDepartment => department!;

  Map<String, dynamic> toJson() {
    return {
      'doctor_name': doctorName,
      'phone_number': phoneNumber,
      'department': department,
    };
  }

  factory Doctor.fromJson(Map<String, dynamic> parsedJson) {
    return Doctor(
      doctorName: parsedJson['doctor_name'],
      phoneNumber: parsedJson['phone_number'],
      department: parsedJson['department'],
    );
  }
}