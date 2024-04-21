import 'package:flutter/material.dart';
import 'package:qr_code_example/screens/tab_box/generate_screen.dart';
import 'package:qr_code_example/screens/tab_box/history/history_screen.dart';
import 'package:qr_code_example/screens/tab_box/scan_screen.dart';
import 'package:qr_code_example/utils/colors/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class TabBox extends StatefulWidget {
  const TabBox({super.key});

  @override
  State<TabBox> createState() => _TabBoxState();
}

class _TabBoxState extends State<TabBox> {
  List<Widget> screens = [];

  @override
  void initState() {
    screens = [
      GenerateScreen(),
      ScanScreen(
        barcode: (Barcode value) {},
      ),
      const HistoryScreen(),
    ];
    super.initState();
  }

  int activeIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.c333333,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: GestureDetector(
        onTap: () {
          activeIndex = 1;
          setState(() {});
        },
        child: SvgPicture.asset(
          "assets/icons/scan.svg",
          width: 110,
          height: 110,
        ),
      ),
      body: screens[activeIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedLabelStyle: const TextStyle(fontFamily: "Itim", fontSize: 17),
        unselectedLabelStyle: const TextStyle(fontFamily: "Itim", fontSize: 14),
        selectedItemColor: AppColors.cFDB623,
        unselectedItemColor: AppColors.cD9D9D9,
        backgroundColor: Colors.black.withOpacity(.2),
        onTap: (newI) {
          newI != 1 ? activeIndex = newI : null;
          setState(() {});
        },
        currentIndex: activeIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_2),
            label: "Generate",
          ),
          BottomNavigationBarItem(icon: Text(""), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "History"),
        ],
      ),
    );
  }
}
