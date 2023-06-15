import 'package:final_bim494_project/commons/theme_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../global_bloc.dart';
import '../../models/doctor.dart';

class DoctorDetails extends StatefulWidget {
  const DoctorDetails(this.doctor, {Key? key}) : super(key: key);
  final Doctor doctor;

  @override
  State<DoctorDetails> createState() => _DoctorDetailsState();
}

class _DoctorDetailsState extends State<DoctorDetails> {
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
            MainSection(doctor: widget.doctor),
            ExtendedSection(doctor: widget.doctor),
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
                  // open alert dialog box, +global bloc, later
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

  // lets delete a doctor from memory

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
                _globalBloc.removeDoctor(widget.doctor);
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

class MainSection extends StatelessWidget {
  const MainSection({Key? key, this.doctor}) : super(key: key);
  final Doctor? doctor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          width: 2.w,
        ),
        Column(
          children: [
            Hero(
              tag: doctor!.doctorName!,
              child: Material(
                color: Colors.transparent,
                child: MainInfoTab(
                    fieldTitle: 'Doctor Name',
                    fieldInfo: doctor!.doctorName!),
              ),
            ),
            MainInfoTab(
                fieldTitle: 'Department',
                fieldInfo: doctor!.department == 0
                    ? 'Not Specified'
                    : "${doctor!.department}"),
          ],
        )
      ],
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
  const ExtendedSection({Key? key, this.doctor}) : super(key: key);
  final Doctor? doctor;

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        ExtendedInfoTab(
          fieldTitle: 'Phone Number',
          fieldInfo: doctor!.phoneNumber == 0
              ? 'Not Specified'
              : "${doctor!.phoneNumber}"
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