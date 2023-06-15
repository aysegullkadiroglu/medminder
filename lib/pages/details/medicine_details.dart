import 'package:final_bim494_project/commons/theme_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../global_bloc.dart';
import '../../models/medicine.dart';

class MedicineDetails extends StatefulWidget {
  const MedicineDetails(this.medicine, {Key? key}) : super(key: key);
  final Medicine medicine;

  @override
  State<MedicineDetails> createState() => _MedicineDetailsState();
}

class _MedicineDetailsState extends State<MedicineDetails> {
  @override
  Widget build(BuildContext context) {
    final GlobalBloc _globalBloc = Provider.of<GlobalBloc>(context);
    return Scaffold(
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
          'Details',
          style: TextStyle(
              color: ThemeUtil.blackColor,
              fontFamily: 'ArchivoNarrow-Medium',
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(2.h),
        child: Column(
          children: [
            ExtendedSection(medicine: widget.medicine),
            Spacer(),
            SizedBox(
              width: 100.w,
              height: 7.h,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Color.fromRGBO(243, 108, 96, 1.0),
                  shape: const StadiumBorder(),
                ),
                onPressed: () {
                  //open alert dialog box,+global bloc, later
                  //cool its working
                  openAlertBox(context, _globalBloc);
                },
                child: Text(
                  'Delete',
                  style: TextStyle(
                    color: ThemeUtil.whiteColor,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
          ],
        ),
      ),
    );
  }
  // lets delete a medicine from memory

  openAlertBox(BuildContext context, GlobalBloc _globalBloc) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0),
            ),
          ),
          contentPadding: EdgeInsets.only(top: 1.h),
          title: Text(
            'Delete This Reminder?',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 17.0,
              fontFamily: 'ArchivoNarrow-Medium',
              fontWeight: FontWeight.w500,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                style: TextStyle(
                  fontSize: 17.0,
                  fontFamily: 'ArchivoNarrow-Medium',
                  fontWeight: FontWeight.w500,
                  color: ThemeUtil.thirdColor,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                //global block to delete medicine,later
                _globalBloc.removeMedicine(widget.medicine);
                Navigator.popUntil(context, ModalRoute.withName('/'));
              },
              child: Text(
                'OK',
                style: TextStyle(
                  fontSize: 17.0,
                  fontFamily: 'ArchivoNarrow-Medium',
                  fontWeight: FontWeight.w500,
                  color: ThemeUtil.thirdColor,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class MainInfoTab extends StatelessWidget {
  const MainInfoTab(
      {Key? key, required this.fieldTitle, required this.fieldInfo})
      : super(key: key);
  final String fieldTitle;
  final String fieldInfo;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40.w,
      height: 10.h,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              fieldTitle,
              style: TextStyle(
                  fontSize: 15.5,
                  fontFamily: 'ArchivoNarrow-Medium',
                fontWeight: FontWeight.w500,
                color: ThemeUtil.fourthColor
              ),
            ),
            SizedBox(
              height: 0.4.h,
            ),
            Text(
              fieldInfo,
              style: TextStyle(
                fontSize: 26.0,
                fontFamily: 'ArchivoNarrow-Medium',
                color: Colors.grey,
            ),
            ),
          ],
        ),
      ),
    );
  }
}


class ExtendedSection extends StatelessWidget {
  const ExtendedSection({Key? key, this.medicine}) : super(key: key);
  final Medicine? medicine;
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        ExtendedInfoTab(
            fieldTitle: 'Dosage',
            fieldInfo: medicine!.dosage == 0
        ? 'Not Specified'
                : "${medicine!.dosage} mg"),
        ExtendedInfoTab(
            fieldTitle: 'Medicine Name',
            fieldInfo: medicine!.medicineName!),
        ExtendedInfoTab(
          fieldTitle: 'Medicine Description ',
          fieldInfo: medicine!.medicineDetail! == 'None'
              ? 'Not Specified'
              : medicine!.medicineDetail!,
        ),
        ExtendedInfoTab(
          fieldTitle: 'Medicine Stock ',
          fieldInfo: medicine!.medicineStock! == 'None'
              ? 'Not Specified'
              : medicine!.medicineStock!.toString(),
        ),
        ExtendedInfoTab(
            fieldTitle: 'Medicine Usage ',
            fieldInfo: medicine!.medicineUsage! == 'None'
                ? 'Not Specified'
                : medicine!.medicineStock!.toString(),
        ),
      ],
    );
  }
}

class ExtendedInfoTab extends StatelessWidget {
  const ExtendedInfoTab(
      {Key? key, required this.fieldTitle, required this.fieldInfo})
      : super(key: key);
  final String fieldTitle;
  final String fieldInfo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 1.h),
            child: Text(
              fieldTitle,
              style: TextStyle(
                  fontSize: 15.5,
                  fontFamily: 'ArchivoNarrow-Medium',
                  fontWeight: FontWeight.w500,
                color: ThemeUtil.fourthColor,
              ),
              ),
            ),
          Text(
            fieldInfo,
            style: TextStyle(
              fontSize: 15.3,
              fontFamily: 'ArchivoNarrow-Medium',
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}