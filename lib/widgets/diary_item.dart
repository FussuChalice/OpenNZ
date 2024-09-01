import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:opennz_ua/colors.dart';
import 'package:opennz_ua/network.dart';
import 'package:opennz_ua/widgets.dart';

enum DiaryItemPosition { top, center, bottom, one }

class DiaryItem extends StatefulWidget {
  const DiaryItem({super.key, required this.position, required this.subjects});

  final DiaryItemPosition position;
  final Subjects subjects;

  @override
  State<DiaryItem> createState() => _DiaryItemState();
}

class _DiaryItemState extends State<DiaryItem> {
  BorderRadiusGeometry getBorderRadiusByPosition(
      DiaryItemPosition diaryItemPostion) {
    switch (diaryItemPostion) {
      case DiaryItemPosition.top:
        return const BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10));
      case DiaryItemPosition.center:
        return BorderRadius.circular(0);
      case DiaryItemPosition.bottom:
        return const BorderRadius.only(
            bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10));

      case DiaryItemPosition.one:
        return const BorderRadius.all(Radius.circular(10));
    }
  }

  Color getMarkColor(String mark) {
    if (mark == "Н") {
      return ApplicationColors.black;
    }

    int markAsNumber = int.parse(mark);

    if ([1, 2, 3, 4, 5, 6].contains(markAsNumber)) {
      return ApplicationColors.markBad;
    } else if ([7, 8, 9].contains(markAsNumber)) {
      return ApplicationColors.markNotBad;
    } else {
      return ApplicationColors.markGood;
    }
  }

  bool moreButtonPressed = false;

  Color getMoreButtonColor() {
    if (widget.subjects.hometask![0] != "") {
      return moreButtonPressed
          ? ApplicationColors.darkGrey
          : ApplicationColors.lightGrey;
    } else {
      return ApplicationColors.greyWhite;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 68,
      decoration: BoxDecoration(
        borderRadius: getBorderRadiusByPosition(widget.position),
        color: ApplicationColors.greyWhite,
      ),
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        top: 11,
        bottom: 11,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.subjects.subjectName!,
                style: TextStyle(
                  color: ApplicationColors.black,
                  fontSize: 17,
                ),
              ),
              widget.subjects.hometask![0] != ""
                  ? SizedBox(
                      width: 180,
                      height: 20,
                      child: Text(
                        widget.subjects.hometask![0],
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 15,
                          color: ApplicationColors.darkGrey,
                        ),
                      ),
                    )
                  : const SizedBox(
                      height: 0,
                      width: 0,
                    ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (widget.subjects.lesson![0].mark != "")
                Row(
                  children: [
                    Text(
                      widget.subjects.lesson![0].mark!,
                      style: TextStyle(
                        color: getMarkColor(widget.subjects.lesson![0].mark!),
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                  ],
                ),
              Listener(
                onPointerDown: (event) {
                  setState(() {
                    moreButtonPressed = true;
                  });
                },
                onPointerUp: (event) {
                  setState(() {
                    moreButtonPressed = false;
                  });
                },
                child: GestureDetector(
                  onTap: () {
                    if (widget.subjects.hometask![0] != "") {
                      showCupertinoDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return diaryDialogWithHometask(
                                context, widget.subjects.hometask![0]);
                          });
                    }
                  },
                  child: Row(
                    children: [
                      Text(
                        AppLocalizations.of(context)!.buttonMore,
                        style: TextStyle(
                          color: getMoreButtonColor(),
                          fontSize: 17,
                        ),
                      ),
                      Icon(
                        Icons.keyboard_arrow_right,
                        color: getMoreButtonColor(),
                        size: 17,
                      )
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
