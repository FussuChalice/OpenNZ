import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:opennz_ua/network.dart';
import 'package:opennz_ua/providers.dart';
import 'package:provider/provider.dart';

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
      appBar: AppBar(),
      body: ListView(
        children: [
          SvgPicture.network(
            DiceBearService.generateAvatarURL(
                DiceBearStyle.identicon, userProvider.user.fio),
            width: 100,
            height: 100,
          ),
        ],
      ),
    );
  }
}
