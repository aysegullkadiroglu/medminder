import 'package:final_bim494_project/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';

import '../commons/theme_util.dart';
import '../global_bloc.dart';
import '../models/medicine.dart';
import '../pages/widget/header_widget.dart';
import 'details/medicine_details.dart';
import 'doctor_page.dart';
import 'medicine_suggestion.dart';
import 'new_entry/new_entry_medicine.dart';


class MedicinePage extends StatefulWidget {
  const MedicinePage({Key? key}) : super(key: key);

  @override
  _MedicinePageState createState() => _MedicinePageState();
}

class _MedicinePageState extends State<MedicinePage> {

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
                  _headerHeight, true, Icons.medication),
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
                return NewEntryMedicine();
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
            'Worry less. \nLive healthier.',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: ThemeUtil.fourthColor,
              fontFamily: 'Mogra-Regular',
              fontSize: 40.0,
            ),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
        Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.only(left: 20.0),
          child: Text(
            'Your Daily Dose',
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
        // lets show number of saved medicines from shared preferences
        StreamBuilder<List<Medicine>>(
            stream: globalBloc.medicineList$,
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
      stream: globalBloc.medicineList$,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          // if no data is saved
          return Container();
        } else if (snapshot.data!.isEmpty) {
          return Center(
            child: Text(
              'No Medicine',
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
              return MedicineCard(medicine: snapshot.data![index]);
            },
          );
        }
      },
    );
  }
}

class NavigationBarPage extends StatefulWidget {
  const NavigationBarPage({Key? key}) : super(key: key);

  @override
  _NavigationBarPageState createState() => _NavigationBarPageState();
}

class _NavigationBarPageState extends State<NavigationBarPage> {
  final Color navigationBarColor = Colors.white;
  int selectedIndex = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    /// [AnnotatedRegion<SystemUiOverlayStyle>] only for android black navigation bar. 3 button navigation control (legacy)

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        systemNavigationBarColor: navigationBarColor,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        // backgroundColor: Colors.grey,
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          children: <Widget>[
            MedicinePage(),
            DoctorPage(),
            MedicineSuggestionPage(),
            ProfilePage(),
          ],
        ),
        bottomNavigationBar: WaterDropNavBar(
          backgroundColor: navigationBarColor,
          onItemSelected: (int index) {
            setState(() {
              selectedIndex = index;
            });
            pageController.animateToPage(selectedIndex,
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeOutQuad);
          },
          selectedIndex: selectedIndex,
          barItems: <BarItem>[
            BarItem(
              filledIcon: Icons.medical_services,
              outlinedIcon: Icons.medical_services_outlined,
            ),
            BarItem(
                filledIcon: Icons.person,
                outlinedIcon: Icons.person_outline),
            BarItem(
              filledIcon: Icons.lightbulb,
              outlinedIcon: Icons.lightbulb_outline,
            ),
            BarItem(
              filledIcon: Icons.account_circle_rounded,
              outlinedIcon: Icons.account_circle_outlined,
            ),
          ],
        ),
      ),
    );
  }
}

class MedicineCard extends StatelessWidget {
  const MedicineCard({Key? key, required this.medicine}) : super(key: key);
  final Medicine medicine;
  // for getting the current details of the saved items

  // first we need to get the medicine type icon
  // lets make a function

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
                    child: MedicineDetails(medicine),
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
                tag: medicine.medicineName!,
                child: Text(
                  medicine.medicineName!,
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