import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:opennz_ua/network.dart';
import 'package:opennz_ua/providers.dart';
import 'package:opennz_ua/screens.dart';
import 'package:opennz_ua/widgets.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DiaryView extends StatefulWidget {
  const DiaryView({super.key});

  @override
  State<DiaryView> createState() => _DiaryViewState();
}

class _DiaryViewState extends State<DiaryView> {
  DateTime _selectedWeekStart =
      DateTime.now().subtract(Duration(days: DateTime.now().weekday - 1));
  DateTime _selectedWeekEnd = DateTime.now()
      .subtract(Duration(days: DateTime.now().weekday - 1))
      .add(const Duration(days: 6));

  Future<DiaryResultModel> loadDiary(DateTime startDate, DateTime endDate,
      int studentId, String accessToken) async {
    StudentPeriodModel studentPeriod = StudentPeriodModel(
        endDate: endDate,
        startDate: startDate,
        studentId: studentId.toString());

    DiaryResultModel diaryResult =
        await DiaryService().fetchDiary(studentPeriod, accessToken);

    return diaryResult;
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Container(
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
          SizedBox(
            child: Column(
              children: [
                CustomAppBar(
                  title: AppLocalizations.of(context)!.diary,
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
                ),
                WeekSelecter(
                  onChange: (DateTime startOfWeek, DateTime endOfWeek) {
                    setState(() {
                      _selectedWeekStart = startOfWeek;
                      _selectedWeekEnd = endOfWeek;
                    });
                  },
                ),
                FutureBuilder(
                  future: loadDiary(
                    _selectedWeekStart,
                    _selectedWeekEnd,
                    userProvider.user.studentId,
                    userProvider.user.accessToken,
                  ),
                  builder: (BuildContext context,
                      AsyncSnapshot<DiaryResultModel> snapshot) {
                    if (snapshot.hasData) {
                      return Text(jsonEncode(snapshot.data!.toJson()));
                    } else {
                      return const CircularProgressIndicator();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
