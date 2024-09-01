import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

CupertinoAlertDialog diaryDialogWithHometask(
    BuildContext context, String hometask) {
  return CupertinoAlertDialog(
    title: Text(AppLocalizations.of(context)!.hometask),
    content: Text(hometask),
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
