import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:opennz_ua/colors.dart';
import 'package:opennz_ua/network/network_cache_manager.dart';
import 'package:opennz_ua/providers.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:opennz_ua/version.dart';
import 'package:opennz_ua/widgets.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      backgroundColor: ApplicationColors.greyWhite,
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.settings,
          style: TextStyle(color: ApplicationColors.black),
        ),
      ),
      body: ListView(
        children: [
          TextDivider(text: AppLocalizations.of(context)!.account),
          const Gap(20),
          ListTile(
            leading: CustomCircleAvatar(
              userName: userProvider.user.fio,
            ),
            title: Text(userProvider.user.fio),
            subtitle: Text(userProvider.user.studentId.toString()),
            onTap: () {},
          ),
          const Gap(40),
          TextDivider(text: AppLocalizations.of(context)!.aboutProject),
          const Gap(20),
          ListTile(
            title: Text(
                "${AppLocalizations.of(context)!.versionB}: $APPLICATION_VERSION"),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            title: Text(AppLocalizations.of(context)!.project),
            onTap: () async {
              await launchUrl(
                  Uri.parse("https://github.com/FussuChalice/OpenNZ"));
            },
          ),
          const Divider(),
          ListTile(
            title: Text(AppLocalizations.of(context)!.licenses),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LicensePage()));
            },
          ),
          const Gap(40),
          TextDivider(text: AppLocalizations.of(context)!.additionaly),
          const Gap(20),
          ListTile(
            title: Text(AppLocalizations.of(context)!.cleanCache),
            onTap: () async {
              await NetworkCacheManager().clearCache();
            },
          )
        ],
      ),
    );
  }
}
