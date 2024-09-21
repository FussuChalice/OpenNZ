import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/widgets.dart';
import 'package:opennz_ua/colors.dart';
import 'package:opennz_ua/network.dart';

class CustomCircleAvatar extends StatelessWidget {
  const CustomCircleAvatar({super.key, required this.userName});

  final String userName;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl:
          DiceBearService.generateAvatarURL(DiceBearStyle.identicon, userName),
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          border: Border.all(width: 2, color: ApplicationColors.greyWhite),
          shape: BoxShape.circle,
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
      width: 50,
      height: 50,
    );
  }
}
