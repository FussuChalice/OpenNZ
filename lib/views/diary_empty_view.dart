import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DiaryEmptyView extends StatefulWidget {
  const DiaryEmptyView({super.key});

  @override
  State<DiaryEmptyView> createState() => _DiaryEmptyViewState();
}

class _DiaryEmptyViewState extends State<DiaryEmptyView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        AppLocalizations.of(context)!.diaryIsEmpty,
        textAlign: TextAlign.center,
      ),
    );
  }
}
