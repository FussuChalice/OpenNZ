import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gap/gap.dart';
import 'package:opennz_ua/colors.dart';
import 'package:opennz_ua/network.dart';
import 'package:opennz_ua/widgets.dart';

CupertinoAlertDialog missedLessonsDialog(
  BuildContext context,
  MissedLessonsModel missedLessons,
) {
  return CupertinoAlertDialog(
    title: Text(AppLocalizations.of(context)!.missedLessons),
    content: Column(
      children: [
        const Gap(10),
        Table(
          border: TableBorder.all(),
          children: [
            TableRow(
              decoration: BoxDecoration(
                color: ApplicationColors.missedLessonsTable,
              ),
              children: [
                CustomTableCell(
                    text: AppLocalizations.of(context)!.date, title: true),
                CustomTableCell(
                    text: AppLocalizations.of(context)!.lesson, title: true),
              ],
            ),
            ...List.generate(
              missedLessons.missedLessons!.length,
              (missedLessonIndex) => TableRow(
                children: [
                  CustomTableCell(
                      text: missedLessons
                          .missedLessons![missedLessonIndex].lessonDate!,
                      title: false),
                  CustomTableCell(
                      text: missedLessons
                          .missedLessons![missedLessonIndex].subject!,
                      title: false),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
    actions: <Widget>[
      CupertinoDialogAction(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text(AppLocalizations.of(context)!.buttonCancel),
      ),
    ],
  );
}
