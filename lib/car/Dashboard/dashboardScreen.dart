import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:veka/car/CarHome/CarHomePage.dart';
import 'package:veka/car/More/more.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _selectedIndex = 0.obs;
     const TextStyle optionStyle =
    TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
     const List<Widget> _widgetOptions = <Widget>[
       CarHomePage(),
      more(),



    ];
    return Scaffold(
      body: Obx(() => Center(
        child: _widgetOptions.elementAt(_selectedIndex.value),
      ),),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: Obx(() => SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              selectedIndex: _selectedIndex.value,
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: Colors.black,
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor: Colors.grey[500]!,
              color: Colors.black,
              tabs: [
                GButton(
                  icon: CupertinoIcons.home,
                  text: 'Home',
                ),

                GButton(
                  icon: CupertinoIcons.settings,
                  text: 'More',
                ),

              ],
              //selectedIndex: _selectedIndex.obs,
              onTabChange: (index) {
                _selectedIndex.value = index;
              },
            ),
          ),
        ),)
      ),
    );
  }
}