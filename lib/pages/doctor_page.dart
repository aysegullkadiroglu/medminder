import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../commons/theme_util.dart';
import '../global_bloc.dart';
import '../models/doctor.dart';
import '../pages/widget/header_widget.dart';
import 'details/doctor_details.dart';
import 'new_entry/new_entry_doctor.dart';


class DoctorPage extends StatefulWidget {
  const DoctorPage({Key? key}) : super(key: key);

  @override
  _DoctorPageState createState() => _DoctorPageState();
}

class _DoctorPageState extends State<DoctorPage> {

  @override
  Widget build(BuildContext context) {
    double _headerHeight = 200;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: _headerHeight,
              child: HeaderWidget(
                  _headerHeight, true, Icons.person_pin_rounded),
            ),
            const TopContainer(),
            BottomContainer(),
          ],
        ),
      ),
      floatingActionButton: InkResponse(
        onTap: () {
          // When navigating to the new page
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return NewEntryDoctor();
              },
            ),
          );
        },
        child: SizedBox(
          width: 60.0,
          height: 60.0,
          child: Card(
            color: ThemeUtil.secondaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
            child: Icon(
              Icons.add_outlined,
              color: ThemeUtil.whiteColor,
              size: 40.0,
            ),
          ),
        ),
      ),
    );
  }
}

class TopContainer extends StatelessWidget {
  const TopContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalBloc globalBloc = Provider.of<GlobalBloc>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.only(left: 20.0, top: 15.0),
          child: Text(
            'Your trusted doctor \nin your pocket.',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: ThemeUtil.fourthColor,
              fontFamily: 'Mogra-Regular',
              fontSize: 32.5,
            ),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
        Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.only(left: 20.0),
          child: Text(
            'Guided by caring hands',
            style: TextStyle(
              color: ThemeUtil.thirdColor,
              fontFamily: 'ArchivoNarrow-Medium',
              fontSize: 20.0,
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.04,
        ),
        // lets show number of saved doctors from shared preferences
        StreamBuilder<List<Doctor>>(
            stream: globalBloc.doctorList$,
            builder: (context, snapshot) {
              return Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(bottom: 5.0),
                child: Text(
                  !snapshot.hasData ? '0' : snapshot.data!.length.toString(),
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              );
            }),
      ],
    );
  }
}

class BottomContainer extends StatelessWidget {
  const BottomContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalBloc globalBloc = Provider.of<GlobalBloc>(context);

    return StreamBuilder(
      stream: globalBloc.doctorList$,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          // if no data is saved
          return Container();
        } else if (snapshot.data!.isEmpty) {
          return Center(
            child: Text(
              'No Doctor',
              style: Theme.of(context).textTheme.displaySmall,
            ),
          );
        } else {
          return GridView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.only(top: 2),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return DoctorCard(doctor: snapshot.data![index]);
            },
          );
        }
      },
    );
  }
}

class DoctorCard extends StatelessWidget {
  const DoctorCard({Key? key, required this.doctor}) : super(key: key);
  final Doctor doctor;
  // for getting the current details of the saved items
  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: ThemeUtil.whiteColor,
      splashColor: Colors.grey,
      onTap: () {
        // go to details activity with animation, later
        Navigator.of(context).push(
          PageRouteBuilder<void>(
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) {
              return AnimatedBuilder(
                animation: animation,
                builder: (context, Widget? child) {
                  return Opacity(
                    opacity: animation.value,
                    child: DoctorDetails(doctor),
                  );
                },
              );
            },
            transitionDuration: const Duration(milliseconds: 500),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.only(left: 2, right: 2, top: 2, bottom: 2),
        margin: EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(
            color: ThemeUtil.thirdColor,
            width: 3,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Hero(
                tag: doctor.doctorName!,
                child: Text(
                  doctor.doctorName!,
                  overflow: TextOverflow.fade,
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ),
            //time interval data with condition, later
          ],
        ),
      ),
    );
  }
}