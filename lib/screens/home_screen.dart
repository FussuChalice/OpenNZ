import 'dart:core';
import 'package:flutter/material.dart';
import 'package:opennz_ua/colors.dart';
import 'package:opennz_ua/providers.dart';
import 'package:opennz_ua/views.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedPageIndex = 0;

  @override
  void initState() {
    super.initState();

    // Init user for use in shared memory
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UserProvider>(context, listen: false).fetchUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> views = [
      const DiaryView(),
      const MarksView(),
      const TimetableView()
    ];

    return Scaffold(
      body: views[_selectedPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: const Icon(Icons.book_outlined),
              label: AppLocalizations.of(context)!.diary),
          BottomNavigationBarItem(
              icon: const Icon(Icons.emoji_events_outlined),
              label: AppLocalizations.of(context)!.marks),
          BottomNavigationBarItem(
              icon: const Icon(Icons.calendar_month),
              label: AppLocalizations.of(context)!.schedule),
          BottomNavigationBarItem(
              icon: const Icon(Icons.open_in_browser),
              label: AppLocalizations.of(context)!.project),
        ],
        backgroundColor: ApplicationColors.black,
        currentIndex: _selectedPageIndex,
        unselectedItemColor: ApplicationColors.greyWhite,
        selectedItemColor: ApplicationColors.bottomNavigationBarSelectedItem,
        unselectedFontSize: 10,
        selectedFontSize: 10,
        iconSize: 20,
        onTap: (value) async {
          if (value == 3) {
            // TODO: Change to project url
            await launchUrl(Uri.parse("https://google.com"));
          } else {
            setState(() {
              _selectedPageIndex = value;
            });
          }
        },
      ),
    );
  }
}
