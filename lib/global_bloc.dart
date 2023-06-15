// This class represents the general business logic
// used throughout in the project package

import 'dart:convert';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/doctor.dart';
import 'models/medicine.dart';

class GlobalBloc {
  BehaviorSubject<List<Medicine>>? _medicineList$;
  BehaviorSubject<List<Medicine>>? get medicineList$ => _medicineList$;

  BehaviorSubject<List<Doctor>>? _doctorList$;
  BehaviorSubject<List<Doctor>>? get doctorList$ => _doctorList$;

  GlobalBloc() {
    _medicineList$ = BehaviorSubject<List<Medicine>>.seeded([]);
    makeMedicineList();
    _doctorList$ = BehaviorSubject<List<Doctor>>.seeded([]);
    makeDoctorList();
  }

  Future removeMedicine(Medicine tobeRemoved) async {
    SharedPreferences sharedUser = await SharedPreferences.getInstance();
    List<String> medicineJsonList = [];

    var blockList = _medicineList$!.value;
    blockList.removeWhere(
            (medicine) => medicine.medicineName == tobeRemoved.medicineName);

    if (blockList.isNotEmpty) {
      for (var blockMedicine in blockList) {
        String medicineJson = jsonEncode(blockMedicine.toJson());
        medicineJsonList.add(medicineJson);
      }
    }

    sharedUser.setStringList('medicines', medicineJsonList);
    _medicineList$!.add(blockList);
  }

  Future updateMedicineList(Medicine newMedicine) async {
    var blocList = _medicineList$!.value;
    blocList.add(newMedicine);
    _medicineList$!.add(blocList);

    Map<String, dynamic> tempMap = newMedicine.toJson();
    SharedPreferences? sharedUser = await SharedPreferences.getInstance();
    String newMedicineJson = jsonEncode(tempMap);
    List<String> medicineJsonList = [];
    if (sharedUser.getStringList('medicines') == null) {
      medicineJsonList.add(newMedicineJson);
    } else {
      medicineJsonList = sharedUser.getStringList('medicines')!;
      medicineJsonList.add(newMedicineJson);
    }
    sharedUser.setStringList('medicines', medicineJsonList);
  }

  Future makeMedicineList() async {
    SharedPreferences? sharedUser = await SharedPreferences.getInstance();
    List<String>? jsonList = sharedUser.getStringList('medicines');
    List<Medicine> prefList = [];

    if (jsonList == null) {
      return;
    } else {
      for (String jsonMedicine in jsonList) {
        dynamic userMap = jsonDecode(jsonMedicine);
        Medicine tempMedicine = Medicine.fromJson(userMap);
        prefList.add(tempMedicine);
      }
      // state update
      _medicineList$!.add(prefList);
    }
  }

  Future removeDoctor(Doctor tobeRemoved) async {
    SharedPreferences sharedUser = await SharedPreferences.getInstance();
    List<String> doctorJsonList = [];

    var blockList = _doctorList$!.value;
    blockList.removeWhere(
            (doctor) => doctor.doctorName == tobeRemoved.doctorName);

    if (blockList.isNotEmpty) {
      for (var blockDoctor in blockList) {
        String doctorJson = jsonEncode(blockDoctor.toJson());
        doctorJsonList.add(doctorJson);
      }
    }

    sharedUser.setStringList('doctors', doctorJsonList);
    _doctorList$!.add(blockList);
  }

  Future updateDoctorList(Doctor newDoctor) async {
    var blocList = _doctorList$!.value;
    blocList.add(newDoctor);
    _doctorList$!.add(blocList);

    Map<String, dynamic> tempMap = newDoctor.toJson();
    SharedPreferences? sharedUser = await SharedPreferences.getInstance();
    String newDoctorJson = jsonEncode(tempMap);
    List<String> doctorJsonList = [];
    if (sharedUser.getStringList('doctors') == null) {
      doctorJsonList.add(newDoctorJson);
    } else {
      doctorJsonList = sharedUser.getStringList('doctors')!;
      doctorJsonList.add(newDoctorJson);
    }
    sharedUser.setStringList('doctors', doctorJsonList);
  }

  Future makeDoctorList() async {
    SharedPreferences? sharedUser = await SharedPreferences.getInstance();
    List<String>? jsonList = sharedUser.getStringList('doctors');
    List<Doctor> prefList = [];

    if (jsonList == null) {
      return;
    } else {
      for (String jsonDoctor in jsonList) {
        dynamic userMap = jsonDecode(jsonDoctor);
        Doctor tempDoctor = Doctor.fromJson(userMap);
        prefList.add(tempDoctor);
      }
      // state update
      _doctorList$!.add(prefList);
    }
  }

  void dispose() {
    _medicineList$!.close();
    _doctorList$!.close();
  }
}