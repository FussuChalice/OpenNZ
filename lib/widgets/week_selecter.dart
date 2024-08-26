import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:opennz_ua/colors.dart';

class WeekSelecter extends StatefulWidget {
  final Function(DateTime startOfWeek, DateTime endOfWeek) onChange;

  const WeekSelecter({super.key, required this.onChange});

  @override
  State<WeekSelecter> createState() => _WeekSelecterState();
}

class _WeekSelecterState extends State<WeekSelecter> {
  DateTime _selectedDate = DateTime.now();

  String getFormattedWeek(BuildContext context) {
    DateTime startOfWeek =
        _selectedDate.subtract(Duration(days: _selectedDate.weekday - 1));
    DateTime endOfWeek = startOfWeek.add(const Duration(days: 6));

    final DateFormat formatter =
        DateFormat('d MMMM, yyyy', AppLocalizations.of(context)!.localeName);

    String formattedStart = formatter.format(startOfWeek);
    String formattedEnd = formatter.format(endOfWeek);

    return '$formattedStart - $formattedEnd';
  }

  void _updateWeek(int days) {
    setState(() {
      _selectedDate = _selectedDate.add(Duration(days: days));
      DateTime startOfWeek =
          _selectedDate.subtract(Duration(days: _selectedDate.weekday - 1));
      DateTime endOfWeek = startOfWeek.add(const Duration(days: 6));

      widget.onChange(startOfWeek, endOfWeek); // Trigger callback on change
    });
  }

  void _previousWeek() {
    _updateWeek(-7);
  }

  void _nextWeek() {
    _updateWeek(7);
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
            onPressed: _previousWeek,
          ),
          Text(
            getFormattedWeek(context),
            style: TextStyle(fontSize: 13, color: ApplicationColors.greyWhite),
          ),
          IconButton(
            icon: Icon(
              Icons.chevron_right,
              color: ApplicationColors.greyWhite,
            ),
            onPressed: _nextWeek,
          ),
        ],
      ),
    );
  }
}
