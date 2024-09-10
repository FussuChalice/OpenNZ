import 'dart:io';

import 'package:flutter/material.dart';
import 'package:opennz_ua/colors.dart';
import 'package:opennz_ua/network.dart';
import 'package:opennz_ua/providers.dart';
import 'package:opennz_ua/views.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SubjectMarksScreen extends StatefulWidget {
  const SubjectMarksScreen(
      {super.key, required this.subjectId, required this.selectedMonth});

  final String subjectId;
  final DateTime selectedMonth;

  @override
  State<SubjectMarksScreen> createState() => _SubjectMarksScreenState();
}

class _SubjectMarksScreenState extends State<SubjectMarksScreen> {
  Future<MarksBySubjectModel> loadMarksByPeriodWithSubject(
      DateTime startDate,
      DateTime endDate,
      int studentId,
      String accessToken,
      String subjectId) async {
    StudentPeriodWithSubjectModel studentPeriodWithSubject =
        StudentPeriodWithSubjectModel(
            endDate: endDate,
            startDate: startDate,
            studentId: studentId.toString(),
            subjectId: subjectId);

    MarksBySubjectModel marks = await MarksService()
        .getMarksBySubject(studentPeriodWithSubject, accessToken);

    return marks;
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return FutureBuilder(
        future: loadMarksByPeriodWithSubject(
            DateTime(widget.selectedMonth.year, widget.selectedMonth.month, 1),
            DateTime(
                widget.selectedMonth.year, widget.selectedMonth.month + 1, 0),
            userProvider.user.studentId,
            userProvider.user.accessToken,
            widget.subjectId),
        builder: (BuildContext context,
            AsyncSnapshot<MarksBySubjectModel> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: DataLoadingView(),
            );
          }

          if (snapshot.hasError) {
            if (snapshot.error is SocketException) {
              return NoInternetConnectionView(
                  onRefreshPressed: () => {Navigator.pop(context)});
            } else {
              return const Center(child: Text('An error occurred'));
            }
          }

          if (!snapshot.hasData ||
              snapshot.data!.lessons == null ||
              snapshot.data!.lessons!.isEmpty) {
            return Scaffold(
              body: const Center(child: Text('No data available')),
              backgroundColor: ApplicationColors.greyWhite,
            );
          }

          return Scaffold(
              appBar: AppBar(
                title: Text(
                  snapshot.data!.lessons![0].subject!,
                  style: TextStyle(color: ApplicationColors.black),
                ),
              ),
              backgroundColor: ApplicationColors.greyWhite,
              body: Scrollbar(
                child: ListView(
                  children: [
                    Table(
                      border: TableBorder.all(
                          color: ApplicationColors.darkGrey, width: 1),
                      children: [
                        TableRow(
                          decoration: BoxDecoration(
                              color: ApplicationColors.subjectMarksTable),
                          children: [
                            TableCell(
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Text(
                                  AppLocalizations.of(context)!.date,
                                  style: TextStyle(
                                    color: ApplicationColors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            TableCell(
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Text(
                                  AppLocalizations.of(context)!.lessonType,
                                  style: TextStyle(
                                    color: ApplicationColors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            TableCell(
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Text(
                                  AppLocalizations.of(context)!.grade,
                                  style: TextStyle(
                                    color: ApplicationColors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                        ...List.generate(
                          snapshot.data!.lessons!.length,
                          (lessonIndex) => TableRow(
                            children: [
                              TableCell(
                                child: Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Text(
                                    snapshot.data!.lessons![lessonIndex]
                                        .lessonDate!,
                                    style: TextStyle(
                                      color: ApplicationColors.black,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Text(
                                    snapshot.data!.lessons![lessonIndex]
                                        .lessonType!,
                                    style: TextStyle(
                                      color: ApplicationColors.black,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Text(
                                    snapshot.data!.lessons![lessonIndex].mark!,
                                    style: TextStyle(
                                      color: ApplicationColors.black,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        ...List.generate(
                          45 - snapshot.data!.lessons!.length,
                          (rowIndex) => const TableRow(
                            children: [
                              TableCell(
                                child: Padding(
                                  padding: EdgeInsets.all(5),
                                  child: Text(""),
                                ),
                              ),
                              TableCell(
                                child: Padding(
                                  padding: EdgeInsets.all(5),
                                  child: Text(""),
                                ),
                              ),
                              TableCell(
                                child: Padding(
                                  padding: EdgeInsets.all(5),
                                  child: Text(
                                    "",
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ));
        });
  }
}
