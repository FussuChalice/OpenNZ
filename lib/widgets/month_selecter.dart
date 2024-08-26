import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:opennz_ua/colors.dart';

class MonthSelecter extends StatefulWidget {
  final Function(DateTime selectedMonth) onChange;

  const MonthSelecter({super.key, required this.onChange});

  @override
  State<MonthSelecter> createState() => _MonthSelecterState();
}

class _MonthSelecterState extends State<MonthSelecter> {
  DateTime _selectedDate = DateTime.now();

  String getFormattedMonth(BuildContext context) {
    final DateFormat formatter =
        DateFormat.yMMMM(AppLocalizations.of(context)!.localeName);
    String formattedDate = formatter.format(_selectedDate);

    // Capitalize the first letter of the month
    return formattedDate[0].toUpperCase() + formattedDate.substring(1);
  }

  void _updateMonth(int months) {
    setState(() {
      _selectedDate =
          DateTime(_selectedDate.year, _selectedDate.month + months);
      widget.onChange(_selectedDate); // Trigger callback on change
    });
  }

  void _previousMonth() {
    _updateMonth(-1);
  }

  void _nextMonth() {
    _updateMonth(1);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 45,
      color: ApplicationColors.black,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(
              Icons.chevron_left,
              color: ApplicationColors.greyWhite,
            ),
            onPressed: _previousMonth,
          ),
          Text(
            getFormattedMonth(context),
            style: TextStyle(fontSize: 13, color: ApplicationColors.greyWhite),
          ),
          IconButton(
            icon: Icon(
              Icons.chevron_right,
              color: ApplicationColors.greyWhite,
            ),
            onPressed: _nextMonth,
          ),
        ],
      ),
    );
  }
}
