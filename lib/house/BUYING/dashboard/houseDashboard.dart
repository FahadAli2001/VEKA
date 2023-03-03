import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../houseHome/houseHome.dart';
import '../more/More.dart';


class houseDashboard extends StatelessWidget {
  const houseDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _selectedIndex = 0.obs;
    const TextStyle optionStyle =
    TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
    const List<Widget> _widgetOptions = <Widget>[
      houseHome(),
      More()

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
