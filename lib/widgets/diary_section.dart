import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:opennz_ua/colors.dart';
import 'package:opennz_ua/network.dart';
import 'package:opennz_ua/widgets.dart';

class DiarySection extends StatelessWidget {
  const DiarySection({super.key, required this.date, required this.calls});

  final String date;
  final List<Calls> calls;

  String formatDateToTitle(BuildContext context, String date) {
    DateTime parsedDate = DateTime.parse(date);

    final DateFormat formatter =
        DateFormat('d MMMM, yyyy', AppLocalizations.of(context)!.localeName);

    String formattedDate = formatter.format(parsedDate);

    List<String> parts = formattedDate.split(' ');
    if (parts.length > 1) {
      String month = parts[1];
      parts[1] = month[0].toUpperCase() + month.substring(1).toLowerCase();
    }

    return parts.join(' ');
  }

  DiaryItemPosition getDiaryItemPositionByListIndex(int index, int length) {
    if (index == 0 && index == length - 1) {
      return DiaryItemPosition.one;
    } else if (index == 0) {
      return DiaryItemPosition.top;
    } else if (index == length - 1) {
      return DiaryItemPosition.bottom;
    } else {
      return DiaryItemPosition.center;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Subjects> subjects =
        calls.expand((call) => call.subjects ?? []).cast<Subjects>().toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Gap(28),
        Text(
          formatDateToTitle(context, date),
          style: TextStyle(
            color: ApplicationColors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Gap(16),
        Column(
          children: List.generate(
            subjects.length,
            (subjectIndex) => Column(
              children: [
                DiaryItem(
                  position: getDiaryItemPositionByListIndex(
                      subjectIndex, subjects.length),
                  subjects: subjects[subjectIndex],
                ),
                const Gap(1),
              ],
            ),
          ),
        )
      ],
    );
  }
}
