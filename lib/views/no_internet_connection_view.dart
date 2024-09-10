import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:opennz_ua/colors.dart';
import 'package:opennz_ua/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NoInternetConnectionView extends StatefulWidget {
  const NoInternetConnectionView({super.key, this.onRefreshPressed});

  final void Function()? onRefreshPressed;

  @override
  State<NoInternetConnectionView> createState() =>
      _NoInternetConnectionViewState();
}

class _NoInternetConnectionViewState extends State<NoInternetConnectionView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.signal_wifi_connected_no_internet_4,
          color: ApplicationColors.black,
          size: 80,
        ),
        const Gap(20),
        Text(
          AppLocalizations.of(context)!.ooops,
          style: TextStyle(
            color: ApplicationColors.black,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          AppLocalizations.of(context)!.noInternetConnectionDesc,
          style: TextStyle(
            color: ApplicationColors.black,
            fontSize: 12,
          ),
          textAlign: TextAlign.center,
        ),
        const Gap(50),
        CustomFilledButton(
          label: AppLocalizations.of(context)!.tryAgain,
          onPressed: widget.onRefreshPressed,
        ),
      ],
    );
  }
}
