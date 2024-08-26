import 'package:opennz_ua/network.dart';

class DiceBearService {
  DiceBearService._();

  static const String baseURL = "https://api.dicebear.com/9.x";

  static String _getStyle(DiceBearStyle style) {
    switch (style) {
      case DiceBearStyle.adventurer:
        return "adventurer";
      case DiceBearStyle.adventurerNeutral:
        return "adventurer-neutral";
      case DiceBearStyle.avataaars:
        return "avataaars";
      case DiceBearStyle.avataaarsNeutral:
        return "avataaars-neutral";
      case DiceBearStyle.bigEars:
        return "big-ears";
      case DiceBearStyle.bigEarsNeutral:
        return "big-ears-neutral";
      case DiceBearStyle.bigSmile:
        return "big-smile";
      case DiceBearStyle.bottts:
        return "bottts";
      case DiceBearStyle.botttsNeutral:
        return "bottts-neutral";
      case DiceBearStyle.croodles:
        return "croodles";
      case DiceBearStyle.croodlesNeutral:
        return "croodles-neutral";
      case DiceBearStyle.dylan:
        return "dylan";
      case DiceBearStyle.funEmoji:
        return "fun-emoji";
      case DiceBearStyle.glass:
        return "glass";
      case DiceBearStyle.icons:
        return "icons";
      case DiceBearStyle.identicon:
        return "identicon";
      case DiceBearStyle.initials:
        return "initials";
      case DiceBearStyle.lorelei:
        return "lorelei";
      case DiceBearStyle.loreleiNeutral:
        return "lorelei-neutral";
      case DiceBearStyle.micah:
        return "micah";
      case DiceBearStyle.miniavs:
        return "miniavs";
      case DiceBearStyle.notianists:
        return "notianists";
      case DiceBearStyle.notianistsNeutral:
        return "notianists-neutral";
      case DiceBearStyle.openPeeps:
        return "open-peeps";
      case DiceBearStyle.personas:
        return "personas";
      case DiceBearStyle.pixelArt:
        return "pixel-art";
      case DiceBearStyle.pixelArtNeutral:
        return "pixel-art-neutral";
      case DiceBearStyle.rings:
        return "rings";
      case DiceBearStyle.shapes:
        return "shapes";
      case DiceBearStyle.thumbs:
        return "thumbs";
      default:
        return "identicon";
    }
  }

  static String generateAvatarURL(DiceBearStyle style, String seed) {
    String convertedStyle = _getStyle(style);

    return "$baseURL/$convertedStyle/svg?seed=$seed";
  }
}
