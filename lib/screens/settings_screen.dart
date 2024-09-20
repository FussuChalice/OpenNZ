import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:opennz_ua/colors.dart';
import 'package:opennz_ua/network.dart';
import 'package:opennz_ua/providers.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:opennz_ua/screens.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';
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

    // CachedNetworkImage(
    //   imageUrl: DiceBearService.generateAvatarURL(
    //       DiceBearStyle.identicon, userProvider.user.fio),
    //   width: 100,
    //   height: 100,
    // );

    return Scaffold(
      appBar: AppBar(),
      body: SettingsList(
        sections: [
          SettingsSection(
            title: Text(AppLocalizations.of(context)!.account),
            tiles: <SettingsTile>[
              SettingsTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userProvider.user.fio,
                      style: TextStyle(
                        color: ApplicationColors.black,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      userProvider.user.studentId.toString(),
                      style: TextStyle(
                        color: ApplicationColors.darkGrey,
                        fontSize: 16,
                      ),
                    )
                  ],
                ),
                value: Padding(
                  padding: const EdgeInsets.all(15),
                  child: CachedNetworkImage(
                    imageUrl: DiceBearService.generateAvatarURL(
                        DiceBearStyle.identicon, userProvider.user.fio),
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 2, color: ApplicationColors.greyWhite),
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    width: 50,
                    height: 50,
                  ),
                ),
              ),
              SettingsTile(
                title: Text(
                  AppLocalizations.of(context)!.logOut,
                  style: TextStyle(color: ApplicationColors.logOutButtonRed),
                ),
                onPressed: (context) async {
                  var box = await Hive.openBox("auth_data");
                  await box.clear();

                  if (context.mounted) {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LogInScreen()));
                  }
                },
                leading: Icon(
                  Icons.login_outlined,
                  color: ApplicationColors.logOutButtonRed,
                ),
              )
            ],
          ),
          SettingsSection(tiles: [
            SettingsTile(
              title: Text("Clear cache"),
              onPressed: (context) async {
                await NetworkCacheManager().clearCache();
              },
            )
          ]),
          SettingsSection(
              title: Text(AppLocalizations.of(context)!.projectAndLicenses),
              tiles: [
                SettingsTile(
                  title: Text(AppLocalizations.of(context)!.project),
                  onPressed: (context) async {
                    await launchUrl(
                        Uri.parse("https://github.com/FussuChalice/OpenNZ"));
                  },
                  leading: Icon(
                    Icons.open_in_browser,
                    color: ApplicationColors.black,
                  ),
                ),
                SettingsTile(
                  title: Text(AppLocalizations.of(context)!.licenses),
                  onPressed: (context) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LicensePage(),
                      ),
                    );
                  },
                  leading: Icon(
                    Icons.text_snippet_outlined,
                    color: ApplicationColors.black,
                  ),
                ),
              ])
        ],
      ),
    );
  }
}
