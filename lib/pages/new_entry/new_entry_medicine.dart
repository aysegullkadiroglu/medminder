import 'dart:math';
import 'package:final_bim494_project/commons/theme_util.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:provider/provider.dart';
import '../../global_bloc.dart';
import '../../models/errors.dart';
import '../../models/medicine.dart';
import '../../success_screen.dart';
import 'new_entry_bloc.dart';

class NewEntryMedicine extends StatefulWidget {
  const NewEntryMedicine({Key? key}) : super(key: key);

  @override
  State<NewEntryMedicine> createState() => _NewEntryMedicineState();
}

class _NewEntryMedicineState extends State<NewEntryMedicine> {
  late TextEditingController nameController;
  late TextEditingController descriptionController;
  late TextEditingController dosageController;
  late NewEntryBloc _newEntryBloc;
  late GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    descriptionController.dispose();
    dosageController.dispose();
    _newEntryBloc.dispose();
  }

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    descriptionController = TextEditingController();
    dosageController = TextEditingController();
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
          'Add Medicine',
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
                  Text('Medicine Name: ',
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
                    .copyWith(
                    color: ThemeUtil.blackColor,
                ),
              ),
              Row(
                children: <Widget>[
                  Text('Medicine Description: ',
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
                controller: descriptionController,
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
              Text('Dosage in mg: ',
                style: TextStyle(
                    fontSize: 15.0,
                    fontFamily: 'ArchivoNarrow-Medium'
                ),),
              TextFormField(
                maxLength: 12,
                controller: dosageController,
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
              SizedBox(height: 1.h,),
              Row(
                children: [
                  Text(
                    'Medicine Stock: ',
                    style: TextStyle(
                      fontSize: 15.0,
                      fontFamily: 'ArchivoNarrow-Medium',
                    ),
                  ),
                  SizedBox(width: 1.h,),
                  IntervalSelection(),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Medicine Usage: ',
                    style: TextStyle(
                      fontSize: 15.0,
                      fontFamily: 'ArchivoNarrow-Medium',
                    ),
                  ),
                  SizedBox(width: 1.h, ),
                  IntervalSelection(),
                ],
              ),
              SizedBox(
                height: 3.h,
              ),
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
                      // add medicine
                      // some validations
                      // go to success screen
                      String? medicineName;
                      String? medicineDetail;
                      int? dosage;

                      // medicineName
                      if (nameController.text == "") {
                        _newEntryBloc.submitError(EntryError.nameNull);
                        return;
                      }
                      if (nameController.text != "") {
                        medicineName = nameController.text;
                      }
                      // medicine description
                      if (descriptionController.text == "") {
                        _newEntryBloc.submitError(EntryError.nameNull);
                        return;
                      }
                      if (descriptionController.text != "") {
                        medicineDetail = descriptionController.text;
                      }
                      // dosage
                      if (dosageController.text == "") {
                        dosage = 0;
                      }
                      if (dosageController.text != "") {
                        dosage = int.parse(dosageController.text);
                      }
                      for (var medicine in globalBloc.medicineList$!.value) {
                        if (medicineName == medicine.medicineName) {
                          _newEntryBloc.submitError(EntryError.nameDuplicate);
                          return;
                        }
                      }

                      int medicineStock = _newEntryBloc.selectIntervalStock!.value;
                      int medicineUsage =
                          _newEntryBloc.selectIntervalUsage!.value;

                      Medicine newEntryMedicine = Medicine(
                          medicineName: medicineName,
                          medicineDetail: medicineDetail,
                          dosage: dosage,
                          medicineUsage: medicineUsage,
                          medicineStock: medicineStock,
                          );

                      // update medicine list via global bloc
                      globalBloc.updateMedicineList(newEntryMedicine);

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
          displayError("Please enter the medicine's name");
          break;

        case EntryError.nameDuplicate:
          displayError("Medicine name already exists");
          break;
        case EntryError.dosage:
          displayError("Please enter the dosage required");
          break;
        case EntryError.usage:
          displayError("Please select the medicine usage");
          break;
        case EntryError.stock:
          displayError("Please select the medicine stock");
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

class IntervalSelection extends StatefulWidget {
  const IntervalSelection({Key? key}) : super(key: key);

  @override
  State<IntervalSelection> createState() => _IntervalSelectionState();
}

class _IntervalSelectionState extends State<IntervalSelection> {
  final intervals = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20];
  var _selected = 0;

  @override
  Widget build(BuildContext context) {
    final NewEntryBloc newEntryBloc = Provider.of<NewEntryBloc>(context);
    return Padding(
      padding: EdgeInsets.only(top: 1.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          DropdownButton(
            iconEnabledColor: Colors.grey,
            dropdownColor: ThemeUtil.whiteColor,
            itemHeight: 8.h,
            hint: _selected == 0
                ? Text(
              'Select an interval',
              style: TextStyle(
                color: ThemeUtil.blackColor,
                fontSize: 16.0,
                fontFamily: 'ArchivoNarrow-Medium',
              ),
            )
                : null,
            elevation: 4,
            value: _selected == 0 ? null : _selected,
            items: intervals.map(
                  (int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text(
                    value.toString(),
                    style: TextStyle(
                      color: ThemeUtil.blackColor,
                      fontSize: 16.0,
                      fontFamily: 'ArchivoNarrow-Medium',
                    ),
                  ),
                );
              },
            ).toList(),
            onChanged: (newVal) {
              setState(
                    () {
                  _selected = newVal!;
                  newEntryBloc.updateIntervalUsage(newVal);
                },
              );
            },
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