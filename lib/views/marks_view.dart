import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gap/gap.dart';
import 'package:opennz_ua/colors.dart';
import 'package:opennz_ua/providers.dart';
import 'package:opennz_ua/screens.dart';
import 'package:opennz_ua/views.dart';
import 'package:opennz_ua/widgets.dart';
import 'package:opennz_ua/network.dart';
import 'package:provider/provider.dart';

class MarksView extends StatefulWidget {
  const MarksView({super.key});

  @override
  State<MarksView> createState() => _MarksViewState();
}

class _MarksViewState extends State<MarksView> {
  DateTime _selectedMonth = DateTime.now();

  Future<MissedLessonsModel> loadMissedLessons(DateTime startDate,
      DateTime endDate, int studentId, String accessToken) async {
    StudentPeriodModel studentPeriod = StudentPeriodModel(
        endDate: endDate,
        startDate: startDate,
        studentId: studentId.toString());

    MissedLessonsModel missedLessons = await MissedLessonsService()
        .fetchMissedLessons(studentPeriod, accessToken);

    return missedLessons;
  }

  Future<MarksByPeriodModel> loadMarksByPeriod(DateTime startDate,
      DateTime endDate, int studentId, String accessToken) async {
    StudentPeriodModel studentPeriod = StudentPeriodModel(
        endDate: endDate,
        startDate: startDate,
        studentId: studentId.toString());

    MarksByPeriodModel marks =
        await MarksService().getMarksByPeriod(studentPeriod, accessToken);

    return marks;
  }

  void refreshMarks(BuildContext context) {
    final currentMonth = _selectedMonth;

    setState(() {
      _selectedMonth = DateTime.now();
    });

    // fetch user access key
    Provider.of<UserProvider>(context, listen: false).fetchUser();

    setState(() {
      _selectedMonth = currentMonth;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        gradient: ApplicationColors.backgroundGradient,
      ),
      child: Column(
        children: [
          CustomAppBar(
            title: AppLocalizations.of(context)!.marks,
            additionalButton: FutureBuilder<MissedLessonsModel>(
              future: loadMissedLessons(
                  DateTime(_selectedMonth.year, _selectedMonth.month, 1),
                  DateTime(_selectedMonth.year, _selectedMonth.month + 1, 0),
                  userProvider.user.studentId,
                  userProvider.user.accessToken),
              builder: (BuildContext context,
                  AsyncSnapshot<MissedLessonsModel> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Gap(0);
                }

                if (snapshot.hasError) {
                  return const Gap(0);
                }

                if (!snapshot.hasData ||
                    snapshot.data == null ||
                    snapshot.data!.missedLessons == null ||
                    snapshot.data!.missedLessons!.isEmpty) {
                  return const Gap(0);
                }

                return IconButton(
                  icon: const Icon(Icons.person_off_outlined),
                  onPressed: () {
                    showCupertinoDialog(
                        context: context,
                        builder: (context) =>
                            missedLessonsDialog(context, snapshot.data!));
                  },
                  color: ApplicationColors.black,
                );
              },
            ),
            onSettingsBtnPress: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsScreen(),
                ),
              );
            },
          ),
          MonthSelecter(
            onChange: (date) => {
              setState(() {
                _selectedMonth = date;
              })
            },
          ),
          Expanded(
              child: FutureBuilder<MarksByPeriodModel>(
            future: loadMarksByPeriod(
              DateTime(_selectedMonth.year, _selectedMonth.month, 1),
              DateTime(_selectedMonth.year, _selectedMonth.month + 1, 0),
              userProvider.user.studentId,
              userProvider.user.accessToken,
            ),
            builder: (BuildContext context,
                AsyncSnapshot<MarksByPeriodModel> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const DataLoadingView();
              }

              if (snapshot.hasError) {
                if (snapshot.error is SocketException) {
                  return NoInternetConnectionView(
                      onRefreshPressed: () => {refreshMarks(context)});
                } else {
                  return const Center(child: Text('An error occurred'));
                }
              }

              if (!snapshot.hasData ||
                  snapshot.data == null ||
                  snapshot.data!.subjects == null ||
                  snapshot.data!.subjects!.isEmpty) {
                return const MarksEmptyView();
              }

              return Scrollbar(
                  child: ListView(
                padding: const EdgeInsets.only(left: 17, right: 17),
                children: List.generate(
                  snapshot.data!.subjects!.length,
                  (subjectIndex) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (subjectIndex == 0) const Gap(28),
                      MarksPreviewItem(
                        subjectName:
                            snapshot.data!.subjects![subjectIndex].subjectName!,
                        marks: snapshot.data!.subjects![subjectIndex].marks!,
                        subjectId:
                            snapshot.data!.subjects![subjectIndex].subjectId!,
                        selectedMonth: _selectedMonth,
                      ),
                      const Gap(5),
                    ],
                  ),
                ),
              ));
            },
          ))
        ],
      ),
    );
  }
}
