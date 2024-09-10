import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gap/gap.dart';
import 'package:opennz_ua/colors.dart';
import 'package:opennz_ua/network.dart';

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
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(AppLocalizations.of(context)!.date),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(AppLocalizations.of(context)!.lesson),
                  ),
                ),
              ],
            ),
            ...List.generate(
              missedLessons.missedLessons!.length,
              (missedLessonIndex) => TableRow(
                children: [
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Text(missedLessons
                          .missedLessons![missedLessonIndex].lessonDate!),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Text(missedLessons
                          .missedLessons![missedLessonIndex].subject!),
                    ),
                  ),
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
