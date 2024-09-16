import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:opennz_ua/colors.dart';

class TimetableDateDivider extends StatelessWidget {
  const TimetableDateDivider({super.key, required this.date});

  final String date;

  String getFormattedDate(BuildContext context, String dateStr) {
    DateTime date = DateTime.parse(dateStr);

    final DateFormat formatter =
        DateFormat('d MMMM, yyyy', AppLocalizations.of(context)!.localeName);

    String formattedDate = formatter.format(date);

    List<String> parts = formattedDate.split(' ');
    parts[1] = parts[1][0].toUpperCase() + parts[1].substring(1);

    return '${parts[0]} ${parts[1]} ${parts[2]}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: ApplicationColors.greyWhite,
      ),
      padding: const EdgeInsets.only(
        top: 31,
        bottom: 31,
        left: 10,
        right: 10,
      ),
      child: Text(
        getFormattedDate(context, date),
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 16,
          color: ApplicationColors.black,
        ),
      ),
    );
  }
}
