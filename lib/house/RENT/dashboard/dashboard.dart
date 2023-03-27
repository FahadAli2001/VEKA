import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../BUYING/more/More.dart';
import '../rentHome/rent_home.dart';

class dashboard extends StatelessWidget {
  final bool isRent;
  const dashboard({Key? key, required this.isRent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _selectedIndex = 0.obs;
    const TextStyle optionStyle =
        TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
    List<Widget> _widgetOptions = <Widget>[
      RentHome(),
      More(
        isRent: true,
      )
    ];
    return Scaffold(
      body: Obx(
        () => Center(
          child: _widgetOptions.elementAt(_selectedIndex.value),
        ),
      ),
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
          child: Obx(
            () => SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
                child: GNav(
                  selectedIndex: _selectedIndex.value,
                  rippleColor: Colors.grey[300]!,
                  hoverColor: Colors.grey[100]!,
                  gap: 8,
                  activeColor: Colors.black,
                  iconSize: 24,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  duration: const Duration(milliseconds: 400),
                  tabBackgroundColor: Colors.red,
                  color: Colors.black,
                  tabs: [
                    const GButton(
                      icon: CupertinoIcons.home,
                      text: 'Home',
                    ),
                    const GButton(
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
            ),
          )),
    );
  }
}
