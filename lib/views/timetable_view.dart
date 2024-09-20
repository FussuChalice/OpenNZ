import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:opennz_ua/colors.dart';
import 'package:opennz_ua/network.dart';
import 'package:opennz_ua/providers.dart';
import 'package:opennz_ua/screens.dart';
import 'package:opennz_ua/views.dart';
import 'package:opennz_ua/widgets.dart';
import 'package:provider/provider.dart';

class TimetableView extends StatefulWidget {
  const TimetableView({super.key});

  @override
  State<TimetableView> createState() => _TimetableViewState();
}

class _TimetableViewState extends State<TimetableView> {
  DateTime _selectedWeekStart =
      DateTime.now().subtract(Duration(days: DateTime.now().weekday - 1));
  DateTime _selectedWeekEnd = DateTime.now()
      .subtract(Duration(days: DateTime.now().weekday - 1))
      .add(const Duration(days: 6));

  void refreshTimetable(BuildContext context) {
    final currentWeekStart = _selectedWeekStart;

    setState(() {
      _selectedWeekStart = DateTime.now();
    });

    // fetch user access key
    Provider.of<UserProvider>(context, listen: false).fetchUser();

    setState(() {
      _selectedWeekStart = currentWeekStart;
    });
  }

  bool forceUpdate = false;

  Future<TimetableModel> loadTimetable(DateTime startDate, DateTime endDate,
      int studentId, String accessToken) async {
    StudentPeriodModel studentPeriod = StudentPeriodModel(
        endDate: endDate,
        startDate: startDate,
        studentId: studentId.toString());

    TimetableModel timetable = await TimetableService()
        .getTimetable(studentPeriod, accessToken, forceUpdate);

    return timetable;
  }

  EdgeInsetsGeometry paddingForTimetableTitle =
      const EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 10);

  final int _maxTableRowsCount = 128;

  void updataTimetable() {
    setState(() {
      forceUpdate = true;
    });

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        forceUpdate = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    TableRow timetableTitle = TableRow(
      decoration: BoxDecoration(color: ApplicationColors.purpleTable),
      children: [
        const CustomTableCell(
          text: "№",
          title: true,
          textAlign: TextAlign.center,
          padding: EdgeInsetsDirectional.only(top: 20),
        ),
        CustomTableCell(
          text: AppLocalizations.of(context)!.lesson,
          title: true,
          padding: paddingForTimetableTitle,
        ),
        CustomTableCell(
          text: AppLocalizations.of(context)!.teacher,
          title: true,
          padding: paddingForTimetableTitle,
        ),
        CustomTableCell(
          text: AppLocalizations.of(context)!.cabinet,
          title: true,
          padding: paddingForTimetableTitle,
        ),
        CustomTableCell(
          text: AppLocalizations.of(context)!.startTime,
          title: true,
          padding: paddingForTimetableTitle,
        ),
        CustomTableCell(
          text: AppLocalizations.of(context)!.endTime,
          title: true,
          padding: paddingForTimetableTitle,
        ),
      ],
    );

    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: ApplicationColors.greyWhite,
      child: Column(
        children: [
          CustomAppBar(
            title: AppLocalizations.of(context)!.schedule,
            onSettingsBtnPress: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsScreen(),
                ),
              );
            },
            secondAdditionalButton: IconButton(
              icon: const Icon(Icons.update),
              color: ApplicationColors.black,
              onPressed: () {
                updataTimetable();
              },
            ),
          ),
          WeekSelecter(
            onChange: (DateTime startOfWeek, DateTime endOfWeek) {
              setState(() {
                _selectedWeekStart = startOfWeek;
                _selectedWeekEnd = endOfWeek;
              });
            },
          ),
          Table(
            border: TableBorder.all(
              color: ApplicationColors.darkGrey,
              width: 1,
            ),
            children: [
              timetableTitle,
            ],
          ),
          Expanded(
            child: FutureBuilder(
                future: loadTimetable(_selectedWeekStart, _selectedWeekEnd,
                    userProvider.user.studentId, userProvider.user.accessToken),
                builder: (BuildContext context,
                    AsyncSnapshot<TimetableModel> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const DataLoadingView();
                  }

                  if (snapshot.hasError) {
                    if (snapshot.error is SocketException) {
                      return NoInternetConnectionView(
                          onRefreshPressed: () => {refreshTimetable(context)});
                    } else {
                      return const Center(child: Text('An error occurred'));
                    }
                  }

                  if (!snapshot.hasData ||
                      snapshot.data == null ||
                      snapshot.data!.dates == null ||
                      snapshot.data!.dates!.isEmpty) {
                    return Scrollbar(
                        child: ListView(
                      padding: const EdgeInsets.all(0),
                      children: [
                        Table(
                          border: TableBorder.all(
                            color: ApplicationColors.darkGrey,
                            width: 1,
                          ),
                          children: [
                            ...List.generate(
                              _maxTableRowsCount,
                              (emptyRowIndex) => TableRow(
                                decoration: BoxDecoration(
                                    color: ApplicationColors.greyWhite),
                                children: const [
                                  CustomTableCell(text: "", title: false),
                                  CustomTableCell(text: "", title: false),
                                  CustomTableCell(text: "", title: false),
                                  CustomTableCell(text: "", title: false),
                                  CustomTableCell(text: "", title: false),
                                  CustomTableCell(text: "", title: false),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ));
                  }

                  return Scrollbar(
                    child: ListView(
                      padding: const EdgeInsets.all(0),
                      children: List.generate(
                        snapshot.data!.dates!.length,
                        (dateIndex) => Column(
                          children: [
                            TimetableDateDivider(
                              date: snapshot.data!.dates![dateIndex].date!,
                            ),
                            Table(
                              border: TableBorder.all(
                                color: ApplicationColors.darkGrey,
                                width: 1,
                              ),
                              children: List.generate(
                                snapshot.data!.dates![dateIndex].calls!.length,
                                (callIndex) => TableRow(
                                  decoration: BoxDecoration(
                                      color: ApplicationColors.greyWhite),
                                  children: [
                                    CustomTableCell(
                                      text: snapshot.data!.dates![dateIndex]
                                          .calls![callIndex].callNumber!
                                          .toString(),
                                      title: false,
                                      textAlign: TextAlign.center,
                                      verticalAlignment:
                                          TableCellVerticalAlignment.middle,
                                    ),
                                    CustomTableCell(
                                      text: snapshot
                                          .data!
                                          .dates![dateIndex]
                                          .calls![callIndex]
                                          .subjects![0]
                                          .subjectName!,
                                      title: false,
                                      textAlign: TextAlign.center,
                                    ),
                                    CustomTableCell(
                                      text: snapshot
                                          .data!
                                          .dates![dateIndex]
                                          .calls![callIndex]
                                          .subjects![0]
                                          .teacher!
                                          .name!,
                                      title: false,
                                      textAlign: TextAlign.center,
                                    ),
                                    CustomTableCell(
                                      text: snapshot.data!.dates![dateIndex]
                                          .calls![callIndex].subjects![0].room!,
                                      title: false,
                                      textAlign: TextAlign.center,
                                    ),
                                    CustomTableCell(
                                      text: snapshot.data!.dates![dateIndex]
                                          .calls![callIndex].timeStart!,
                                      title: false,
                                      textAlign: TextAlign.center,
                                    ),
                                    CustomTableCell(
                                      text: snapshot.data!.dates![dateIndex]
                                          .calls![callIndex].timeEnd!,
                                      title: false,
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
