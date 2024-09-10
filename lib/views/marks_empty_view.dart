import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MarksEmptyView extends StatefulWidget {
  const MarksEmptyView({super.key});

  @override
  State<MarksEmptyView> createState() => _MarksEmptyViewState();
}

class _MarksEmptyViewState extends State<MarksEmptyView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        AppLocalizations.of(context)!.marksIsEmpty,
        textAlign: TextAlign.center,
      ),
    );
  }
}
