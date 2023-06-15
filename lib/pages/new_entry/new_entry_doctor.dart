import 'dart:math';
import 'package:final_bim494_project/commons/theme_util.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:provider/provider.dart';
import '../../global_bloc.dart';
import '../../models/doctor.dart';
import '../../models/errors.dart';
import '../../success_screen.dart';
import 'new_entry_bloc.dart';

class NewEntryDoctor extends StatefulWidget {
  const NewEntryDoctor({Key? key}) : super(key: key);

  @override
  State<NewEntryDoctor> createState() => _NewEntryDoctorState();
}

class _NewEntryDoctorState extends State<NewEntryDoctor> {
  late TextEditingController nameController;
  late TextEditingController departmentController;
  late TextEditingController phoneNumberController;
  late NewEntryBloc _newEntryBloc;
  late GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    departmentController.dispose();
    phoneNumberController.dispose();
    _newEntryBloc.dispose();
  }

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    departmentController = TextEditingController();
    phoneNumberController = TextEditingController();
    _newEntryBloc = NewEntryBloc();
    _scaffoldKey = GlobalKey<ScaffoldState>();
    initializeErrorListen();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalBloc globalBloc = Provider.of<GlobalBloc>(context);

    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).padding.top + 32.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: ThemeUtil.blackColor,
          onPressed: () {
            // Navigate back to the previous screen or perform any other action
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          'Add Doctor',
          style: TextStyle(
              color: ThemeUtil.blackColor,
              fontFamily: 'ArchivoNarrow-Medium'
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Provider<NewEntryBloc>.value(
        value: _newEntryBloc,
        child: Padding(
          padding: EdgeInsets.all(2.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget> [
              Row(
                children: <Widget>[
                  Text('Doctor Name: ',
                    style: TextStyle(
                        fontSize: 15.0,
                        fontFamily: 'ArchivoNarrow-Medium'
                    ),),
                  Text(
                    '*',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontFamily: 'ArchivoNarrow-Medium',
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
              TextFormField(
                controller: nameController,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                ),
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(color: ThemeUtil.blackColor),
              ),
              SizedBox(
                height: 2.h,
              ),
              Text('Department: ',
                style: TextStyle(
                    fontSize: 15.0,
                    fontFamily: 'ArchivoNarrow-Medium'
                ),),
              TextFormField(
                controller: departmentController,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                ),
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(color: ThemeUtil.blackColor),
              ),
              SizedBox(
                height: 2.h,
              ),
              Text('Phone Number: ',
                style: TextStyle(
                    fontSize: 15.0,
                    fontFamily: 'ArchivoNarrow-Medium'
                ),),
              TextFormField(
                maxLength: 11,
                controller: phoneNumberController,
                textCapitalization: TextCapitalization.words,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                ),
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(color: ThemeUtil.blackColor),
              ),
              SizedBox(
                height: 2.h,
              ),
              SizedBox(height: 5.h,),
              Padding(
                padding: EdgeInsets.only(
                  left: 8.w,
                  right: 8.w,
                ),
                child: SizedBox(
                  width: 80.w,
                  height: 7.h,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: ThemeUtil.thirdColor,
                      shape: StadiumBorder(),
                    ),
                    child: Center(
                      child: Text(
                        'Confirm',
                        style: TextStyle(
                          color: ThemeUtil.whiteColor,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                    onPressed: () {
                      // add doctor
                      // some validations
                      // go to success screen
                      String? doctorName;
                      String? department;
                      int? phoneNumber;

                      // doctorName
                      if (nameController.text == "") {
                        _newEntryBloc.submitError(EntryError.nameNull);
                        return;
                      }
                      if (nameController.text != "") {
                        doctorName = nameController.text;
                      }
                      // department
                      if (departmentController.text == "") {
                        _newEntryBloc.submitError(EntryError.nameNull);
                        return;
                      }
                      if (departmentController.text != "") {
                        department = departmentController.text;
                      }
                      for (var doctor in globalBloc.doctorList$!.value) {
                        if (doctorName == doctor.doctorName) {
                          _newEntryBloc.submitError(EntryError.nameDuplicate);
                          return;
                        }
                      }
                      // phoneNumber
                      if (phoneNumberController.text == "") {
                        phoneNumber = 0;
                      }
                      if (phoneNumberController.text != "") {
                        phoneNumber = int.parse(phoneNumberController.text);
                      }

                      Doctor newEntryDoctor = Doctor(
                          doctorName: doctorName,
                          department: department,
                          phoneNumber: phoneNumber,
                          );

                      // update doctor list via global bloc
                      globalBloc.updateDoctorList(newEntryDoctor);

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SuccessScreen()));
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void initializeErrorListen() {
    _newEntryBloc.errorState$!.listen((EntryError error) {
      switch (error) {
        case EntryError.nameNull:
          displayError("Please enter the doctor's name");
          break;

        case EntryError.nameDuplicate:
          displayError("Doctor name already exists");
          break;

        case EntryError.phoneNumber:
          displayError("Please enter the phone number");
          break;

        case EntryError.department:
          displayError("Please enter the doctor's department");
          break;

        default:
      }
    });
  }

  void displayError(String error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text(error),
        duration: const Duration(milliseconds: 2000),
      ),
    );
  }

  List<int> makeIDs(double n) {
    var rng = Random();
    List<int> ids = [];
    for (int i = 0; i < n; i++) {
      ids.add(rng.nextInt(1000000000));
    }
    return ids;
  }
}

class DoctorGenderColumn extends StatelessWidget {

  const DoctorGenderColumn(
      {Key? key,
        required this.name,
        required this.iconValue,
        required this.isSelected})
      : super(key: key);

  final String name;
  final String iconValue;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final NewEntryBloc newEntryBloc = Provider.of<NewEntryBloc>(context);
    return GestureDetector(
      child: Column(
        children: [
          Container(
            width: 20.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3.h),
                color: isSelected
                    ? ThemeUtil.thirdColor : ThemeUtil.whiteColor),
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(
                  top: 1.h,
                  bottom: 1.h,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 1.h),
            child: Container(
              width: 20.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: isSelected ? ThemeUtil.secondaryColor : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  name,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: isSelected ?
                  ThemeUtil.whiteColor : Colors.grey),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PanelTitle extends StatelessWidget {
  const PanelTitle({Key? key, required this.title, required this.isRequired})
      : super(key: key);

  final String title;
  final bool isRequired;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 2.h),
      child: Text.rich(
        TextSpan(
          children: <TextSpan>[
            TextSpan(
              text: title,
              style: Theme.of(context).textTheme.labelMedium,
            ),
            TextSpan(
              text: isRequired ? " *" : "",
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: ThemeUtil.blackColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}