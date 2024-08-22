import 'package:flutter/material.dart';
import 'package:opennz_ua/colors.dart';
import 'package:opennz_ua/screens.dart';
import 'package:opennz_ua/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(0.03, -1.00),
            end: Alignment(-0.03, 1),
            colors: [Color(0xFFAABBC3), Color(0xFFDD8D9E), Color(0xFFA28CBA)],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomAppBar(
              title: "Щоденник",
              onCodeBtnPress: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CodeScreen()));
              },
              onSettingsBtnPress: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SettingsScreen()));
              },
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.book_outlined), label: "Щоденник"),
          BottomNavigationBarItem(
              icon: Icon(Icons.emoji_events_outlined), label: "Оцінки"),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month), label: "Розклад"),
          BottomNavigationBarItem(
              icon: Icon(Icons.open_in_browser), label: "Сайт проєкту"),
        ],
        backgroundColor: ApplicationColors.black,
        currentIndex: _selectedPageIndex,
        unselectedItemColor: ApplicationColors.greyWhite,
        selectedItemColor: ApplicationColors.bottomNavigationBarSelectedItem,
        unselectedFontSize: 10,
        selectedFontSize: 10,
        iconSize: 20,
        onTap: (value) {
          setState(() {
            _selectedPageIndex = value;
          });
        },
      ),
    );
  }
}
